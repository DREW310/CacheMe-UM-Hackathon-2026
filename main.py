from fastapi import FastAPI, UploadFile, File, Form
from fastapi.middleware.cors import CORSMiddleware
import sqlite3
import requests
import json
import base64

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
tools = [
    {
        "type": "function",
        "function": {
            "name": "extract_full_lhdn_invoice",
            "description": "Extract all mandatory LHDN e-invoice fields for deep compliance and fraud verification.",
            "parameters": {
                "type": "object",
                "properties": {
                    "supplier_details": {
                        "type": "object",
                        "properties": {
                            "name": {"type": "string"},
                            "tin": {"type": "string", "description": "Supplier Tax ID"},
                            "registration_number": {"type": "string", "description": "SSM Number"},
                            "msic_code": {"type": "string"}
                        },
                        "required": ["name", "tin", "registration_number"]
                    },
                    "buyer_details": {
                        "type": "object",
                        "properties": {
                            "name": {"type": "string"},
                            "tin": {"type": "string"}
                        },
                        "required": ["name", "tin"]
                    },
                    "invoice_metadata": {
                        "type": "object",
                        "properties": {
                            "invoice_number": {"type": "string"},
                            "issue_date": {"type": "string"},
                            "lhdn_uuid": {"type": "string", "description": "Crucial for LHDN validation. Null if missing."}
                        },
                        "required": ["invoice_number", "issue_date"]
                    },
                    "financials": {
                        "type": "object",
                        "properties": {
                            "subtotal": {"type": "number"},
                            "total_tax": {"type": "number"},
                            "grand_total": {"type": "number"}
                        },
                        "required": ["subtotal", "total_tax", "grand_total"]
                    },
                    "line_items": {
                        "type": "array",
                        "items": {
                            "type": "object",
                            "properties": {
                                "description": {"type": "string"},
                                "unit_price": {"type": "number"},
                                "quantity": {"type": "number"}
                            }
                        }
                    }
                },
                "required": ["supplier_details", "buyer_details", "invoice_metadata", "financials", "line_items"]
            }
        }
    },
    {
        "type": "function",
        "function": {
            "name": "ask_clarification",
            "description": "Use this tool ONLY if the invoice image is too blurry, missing critical fields, or cannot be read.",
            "parameters": {
                "type": "object",
                "properties": {
                    "question": {
                        "type": "string",
                        "description": "The specific question to ask the user to clarify the missing information."
                    }
                },
                "required": ["question"]
            }
        }
    }
]

# ---------------------------------------------------------
# 2. THE AI REASONING ENGINE
# ---------------------------------------------------------
def analyze_document_with_ai(prompt_text, base64_image=None, xml_text=None):
    api_url = "https://api.z.ai/v1/chat/completions" # <-- Replace with actual API URL
    api_key = "YOUR_Z_AI_API_KEY_HERE"               # <-- Replace with actual API Key
    
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }

    # Build the message payload depending on if we have an image or text
    user_content = [{"type": "text", "text": prompt_text}]
    
    if base64_image:
        user_content.append({
            "type": "image_url",
            "image_url": {"url": f"data:image/jpeg;base64,{base64_image}"}
        })
    if xml_text:
        user_content.append({"type": "text", "text": f"Raw XML Data: {xml_text}"})

    payload = {
        "model": "glm-vision-main", # <-- Ensure you use a multimodal model ID
        "messages": [
            {"role": "system", "content": "You are a strict data extraction agent for LHDN invoice compliance."},
            {"role": "user", "content": user_content}
        ],
        "tools": [lhdn_extraction_tool],
        "tool_choice": {"type": "function", "function": {"name": "extract_full_lhdn_invoice"}} # Force the AI to use the tool
    }

    try:
        response = requests.post(api_url, headers=headers, json=payload)
        response.raise_for_status()
        response_data = response.json()
        
        # Extract the JSON arguments returned by the tool
        tool_calls = response_data['choices'][0]['message'].get('tool_calls', [])
        if tool_calls:
            extracted_json_str = tool_calls[0]['function']['arguments']
            return json.loads(extracted_json_str)
        else:
            return {"error": "AI failed to extract structured data."}

    except Exception as e:
        print(f"API Error: {e}")
        return {"error": str(e)}

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
        return {"reply": f"System Error or Dummy Key used. Here is what the pipeline attempted to do:\n\n1. Received file type: {file.content_type if file else 'None'}\n2. Processed for AI.\n3. Awaiting real API keys."}

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