from fastapi import FastAPI, UploadFile, File, Form
from fastapi.middleware.cors import CORSMiddleware
import sqlite3
import requests
import json
import base64
import time

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ---------------------------------------------------------
# 1. THE LHDN SCHEMA TOOL (Forces AI to return perfect JSON)
# ---------------------------------------------------------
system_instruction = """
    You are a strict data extraction agent for LHDN invoice compliance. 
    You MUST extract the data from the invoice and return it EXACTLY as a valid JSON object matching this exact structure:
    {
      "supplier_details": {"name": "", "tin": "", "registration_number": "", "msic_code": ""},
      "buyer_details": {"name": "", "tin": ""},
      "invoice_metadata": {"invoice_number": "", "issue_date": "", "lhdn_uuid": "null if missing"},
      "financials": {"subtotal": 0, "total_tax": 0, "grand_total": 0},
      "line_items": [{"description": "", "unit_price": 0, "quantity": 0, "sku": ""}]
    }
    Return ONLY the raw JSON object. Do not include markdown formatting like ```json. Do not include any other text.
    """

# ---------------------------------------------------------
# 2. THE AI REASONING ENGINE
# ---------------------------------------------------------
def analyze_document_with_ai(prompt_text, base64_image=None, xml_text=None):
    api_url = "XXX" # <-- Replace with actual API URL
    api_key = "YYY"               # <-- Replace with actual API Key
    
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }

    # Build the message payload depending on if we have an image or text
    user_content = [{"type": "text", "text": prompt_text}]
    
    if base64_image:
        # Use complex multimodal array ONLY if an image is attached
        user_content = [
            {"type": "text", "text": prompt_text},
            {"type": "image_url", "image_url": {"url": f"data:image/jpeg;base64,{base64_image}"}}
        ]
    else:
        # Use standard text string for XML to prevent API 500 crashes
        user_content = prompt_text
        if xml_text:
            user_content += f"\n\n--- RAW INVOICE DATA ---\n{xml_text}"

    payload = {
        "model": "ilmu-glm-5.1",
        "messages": [
            {"role": "system", "content": system_instruction},
            {"role": "user", "content": user_content}
        ]
        # Notice we completely removed the 'tools' and 'tool_choice' parameters!
    }

    max_retries = 2
    for attempt in range(max_retries):
        try:
            # We add a 60-second timeout so our code doesn't hang forever
            response = requests.post(api_url, headers=headers, json=payload, timeout=60)
            response.raise_for_status()
            response_data = response.json()
            
            message_data = response_data['choices'][0]['message']
            content = message_data.get('content', '')
            
            if "{" in content and "}" in content:
                start = content.find('{')
                end = content.rfind('}') + 1
                return json.loads(content[start:end])
                
            return {"error": "AI response did not contain valid JSON."}

        except requests.exceptions.Timeout:
            if attempt < max_retries - 1:
                print(f"ILMU Server is slow. Retrying... (Attempt {attempt + 2})")
                time.sleep(2) # Wait 2 seconds before trying again
                continue
            return {"error": "ILMU API timed out. The server is currently too slow or overloaded."}
            
        except Exception as e:
            # Catch 504s and other server errors
            if "504" in str(e) and attempt < max_retries - 1:
                print(f"ILMU 504 Gateway Timeout. Retrying... (Attempt {attempt + 2})")
                time.sleep(2)
                continue
                
            print(f"API Error: {e}")
            return {"error": f"ILMU Server Error: {str(e)}"}

# ---------------------------------------------------------
# 3. FASTAPI ENDPOINT (Receives File + Text)
# ---------------------------------------------------------
@app.post("/api/chat")
async def chat_endpoint(
    message: str = Form(...), 
    session_id: str = Form(...), 
    file: UploadFile = File(None)
):
    base64_image = None
    xml_text = None

    # Step 1: Process the uploaded file
    if file:
        file_bytes = await file.read()
        
        # If it's an image, encode to base64 for Vision AI
        if file.content_type in ["image/jpeg", "image/png"]:
            base64_image = base64.b64encode(file_bytes).decode('utf-8')
        
        # If it's XML or text, decode to string
        elif file.content_type in ["text/xml", "application/xml"]:
            xml_text = file_bytes.decode('utf-8')

    # Step 2: Send to AI for Extraction
    extracted_data = analyze_document_with_ai(message, base64_image, xml_text)

    # If the API call failed (e.g., dummy key), return a mock response for testing
    if "error" in extracted_data:
        actual_error = extracted_data["error"]
        return {
            "reply": f"🚨 **AI Extraction Failed!**\n\nHere is the exact reason why:\n{actual_error}", 
            "action": "ERROR"
        }

    # Step 3: Run Database Verification against local umhackathon_2026.db
    fraud_flags = []
    verification_summary = []

    # Connect to the local SQLite database
    try:
        # Note: Ensure your file is named exactly this and is in the same folder
        conn = sqlite3.connect('umhackathon_2026.db') 
        # This makes the database return dictionaries instead of tuples
        conn.row_factory = sqlite3.Row 
        cursor = conn.cursor()

        # --- A. LHDN Compliance Check ---
        lhdn_uuid = extracted_data.get('invoice_metadata', {}).get('lhdn_uuid')
        if not lhdn_uuid or lhdn_uuid.lower() == "null":
            fraud_flags.append("🚨 MISSING LHDN UUID: This invoice is not legally validated by LHDN.")
        else:
            verification_summary.append("✅ LHDN UUID Validated.")

        # --- B. Ghost Vendor Check ---
        ssm_number = extracted_data.get('supplier_details', {}).get('registration_number')
        cursor.execute("SELECT * FROM vendors WHERE ssm_number = ?", (ssm_number,))
        vendor = cursor.fetchone()

        if not vendor:
            fraud_flags.append(f"🚨 GHOST VENDOR: SSM Number {ssm_number} not found in approved vendor database.")
            vendor_id = None
        else:
            vendor_id = vendor['vendor_id']
            verification_summary.append(f"✅ Vendor '{vendor['company_name']}' is registered.")

        # --- C. Double Dipping Check (Only if Vendor exists) ---
        invoice_number = extracted_data.get('invoice_metadata', {}).get('invoice_number')
        if vendor_id and invoice_number:
            cursor.execute("SELECT * FROM processed_invoices WHERE invoice_number = ? AND vendor_id = ?", (invoice_number, vendor_id))
            duplicate = cursor.fetchone()
            if duplicate:
                fraud_flags.append(f"🚨 DUPLICATE INVOICE: Invoice {invoice_number} was already paid on {duplicate['processed_date']}.")
            else:
                verification_summary.append("✅ Invoice Number is unique (No duplicates).")

        # --- D. Overbilling Check (Only if Vendor exists) ---
        line_items = extracted_data.get('line_items', [])
        if vendor_id and line_items:
            for item in line_items:
                sku = item.get('sku')
                billed_price = float(item.get('unit_price', 0))

                if sku:
                    cursor.execute("SELECT agreed_unit_price FROM vendor_contracts WHERE vendor_id = ? AND sku = ?", (vendor_id, sku))
                    contract = cursor.fetchone()

                    if contract:
                        agreed_price = float(contract['agreed_unit_price'])
                        if billed_price > agreed_price:
                            variance = billed_price - agreed_price
                            fraud_flags.append(f"🚨 OVERBILLING: SKU {sku} billed at RM {billed_price}. Contract price is RM {agreed_price} (Variance: RM {variance}).")
                    else:
                        fraud_flags.append(f"⚠️ UNKNOWN ITEM: SKU {sku} is not in the contract for this vendor.")

    except sqlite3.Error as e:
        fraud_flags.append(f"Database Error: {e}")
    finally:
        if conn:
            conn.close()

    # Step 4: Format the final response for the user interface
    status_header = "🛑 **FRAUD DETECTED**" if fraud_flags else "✅ **INVOICE APPROVED**"
    
    formatted_reply = f"{status_header}\n\n"
    
    if fraud_flags:
        formatted_reply += "**Red Flags:**\n" + "\n".join(fraud_flags) + "\n\n"
    
    formatted_reply += "**System Checks:**\n" + "\n".join(verification_summary) + "\n\n"
    
    # Optional: Include the raw JSON to show judges the extraction worked
    formatted_reply += f"*(Extracted JSON data attached below)*\n```json\n{json.dumps(extracted_data, indent=2)}\n```"

    return {"reply": formatted_reply, "action": "ANALYSIS_COMPLETE"}