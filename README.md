# UM Hackathon 2026: LHDN Fraud Detective Agent

## Submission Links
- **Pitching Video:** [YouTube Link](https://youtu.be/U_C0sG3KwBw)

**Automated e-Invoice Clearing House & Compliance Verification System**

An intelligent FastAPI-based application that processes, validates, and bridges Malaysian e-invoices to the LHDN (Lembaga Hasil Dalam Negeri) system. The system uses AI-powered OCR and document extraction to identify fraud, verify vendor compliance, and ensure invoice authenticity.

---

## 📋 Table of Contents

- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Database Setup](#-database-setup)
- [Running the Application](#-running-the-application)
- [Project Structure](#-project-structure)
- [API Endpoints](#-api-endpoints)
- [Usage Guide](#-usage-guide)
- [Chatbot Interface Overview](#chatbot-interface-overview)
- [Chatbot Functions & Features](#-chatbot-functions--features)
- [Chatbot Interaction Workflows](#-chatbot-interaction-workflows)
- [Chatbot Response Types](#-chatbot-response-types--meanings)
- [Voice & Accessibility Features](#-voice--accessibility-features)
- [Certificate Generation & Download](#-certificate-generation--download)
- [Troubleshooting](#-troubleshooting)

---

## ✨ Features

- **Multi-Format Document Processing**: Supports images (PNG, JPEG), XML, JSON, PDFs, Word documents (.docx), and Excel files (.xlsx)
- **AI-Powered Extraction**: Uses advanced OCR and natural language processing via ILMU AI API to extract invoice data
- **Fraud Detection**: Real-time verification against vendor database with multiple security checks:
  - Double-dipping detection (duplicate invoice prevention)
  - Vendor registration verification
  - TIN/SSM number validation
  - Overbilling detection
- **B2B & B2C Processing**: Handles both enterprise invoices and retail cash receipts
- **Month-End Consolidation**: Aggregates retail cash receipts into official LHDN-compliant invoices
- **LHDN UUID Generation**: Auto-generates unique identifiers for bridge-to-LHDN compliance
- **Certificate Generation**: Creates official HTML approval certificates for approved invoices
- **Human-in-the-Loop Validation**: Interactive correction of missing or ambiguous fields
- **SQLite Database Integration**: Persistent vendor, invoice, and compliance tracking

---

## 🔧 Prerequisites

Before running this application, ensure you have:

- **Python 3.8+** installed
- **pip** (Python package manager)
- **Git** (for version control)
- **Windows PowerShell** or equivalent terminal (for running the 2 concurrent terminals)
- **Modern web browser** (Chrome, Firefox, Edge for frontend access)

---

## 📦 Installation

### Step 1: Clone or Download the Project

```bash
cd "c:\Users\User\UM hacketon 2026"
```

### Step 2: Create a Virtual Environment

It's recommended to create an isolated Python virtual environment:

**On PowerShell:**
```powershell
python -m venv venv
```

**Activate the virtual environment:**
```powershell
.\venv\Scripts\Activate.ps1
```

> **Note**: If you get an execution policy error, run:
> ```powershell
> Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
> ```

### Step 3: Install Dependencies

```bash
pip install -r requirements.txt
```

You'll need to add a few additional packages that may not be in requirements.txt:

```bash
pip install python-docx openpyxl PyPDF2 requests
```

---

## 🗄️ Database Setup

### Initialize the Database

The application uses SQLite for persistent storage. Initialize it by running:

```bash
python setup_db.py
```

This command will:
- Create a new `umhackathon_2026.db` SQLite database
- Build all required tables (vendors, processed_invoices, approved_e_invoices, products, retail_cash_receipts)
- Populate sample vendor and product data

### Optional: Seed Additional Tables

If you need to populate additional tables with sample data:

```bash
python add_approved_table.py
python add_retail_table.py
python add_audit_table.py
```

---

## 🚀 Running the Application

The application requires **2 concurrent terminals** to run properly:

### **Terminal 1: FastAPI Backend Server**

This terminal runs the API that processes invoices.

```powershell
# Activate virtual environment (if not already active)
.\venv\Scripts\Activate.ps1

# Start the FastAPI server using uvicorn
uvicorn main:app --reload --host 127.0.0.1 --port 8000
```

**Expected Output:**
```
INFO:     Uvicorn running on http://127.0.0.1:8000
INFO:     Application startup complete
```

The FastAPI server will be available at: **http://localhost:8000**

---

### **Terminal 2: Static File Server**

This terminal serves the frontend HTML interface on a separate port.

```powershell
# Activate virtual environment (if not already active)
.\venv\Scripts\Activate.ps1

# Start the Python HTTP server
python -m http.server 8080
```

**Expected Output:**
```
Serving HTTP on 0.0.0.0 port 8080 (http://0.0.0.0:8080/) ...
```

The frontend will be available at: **http://localhost:8080/templates/index.html**

---

## 📁 Project Structure

```
UM hacketon 2026/
├── main.py                          # FastAPI application with all business logic
├── setup_db.py                      # Database initialization script
├── add_approved_table.py            # Populate approved invoices table
├── add_retail_table.py              # Populate retail cash receipts table
├── add_audit_table.py               # Populate audit logs table
├── test_api.py                      # API testing utilities
├── requirements.txt                 # Python dependencies
├── umhackathon_2026.db             # SQLite database (created after setup_db.py runs)
├── umhackathon_2026.sql            # SQL schema reference
├── README.md                        # This file
└── templates/
    └── index.html                   # Web frontend (Vue.js-style chat interface)
```

### Key Files Explained

| File | Purpose |
|------|---------|
| **main.py** | Core FastAPI application containing:<br/>- `/api/chat` endpoint for document processing<br/>- AI extraction logic<br/>- Fraud detection algorithms<br/>- Database verification<br/>- Certificate generation |
| **setup_db.py** | Creates SQLite database schema and populates vendors/products |
| **index.html** | Interactive chat interface for uploading documents and viewing results |
| **umhackathon_2026.sql** | SQL schema reference (informational) |

---

## 🔌 API Endpoints

### POST `/api/chat`

**Purpose**: Process and verify e-invoices

**Request (multipart/form-data):**
```
- message: string (required) - User instructions or invoice data
- session_id: string (required) - Unique session identifier
- file: file (optional) - Document file (images, PDF, XML, JSON, DOCX, XLSX)
```

**Response:**
```json
{
  "reply": "string - formatted response with verification results",
  "action": "ANALYSIS_COMPLETE|AWAITING_USER_DECISION|ERROR",
  "certificate": "string - HTML certificate (if approved)",
  "missing_fields": ["array of field names if incomplete"],
  "partial_data": "object - extracted data"
}
```

**Special Commands:**
- `CONSOLIDATE` - Triggers month-end consolidation of retail cash receipts
- `FINAL_DATA:` - Submit completed extracted data for final verification

---

## 📖 Usage Guide

### Chatbot Interface Overview

The LHDN Fraud Detective chatbot is an interactive chat interface designed to process and validate e-invoices. Here's what you'll see:

```
┌─────────────────────────────────────────┐
│  LHDN Fraud Detective Agent             │
├─────────────────────────────────────────┤
│                                         │
│  💬 Chat messages appear here           │
│  (Bot responses + Your uploads)         │
│                                         │
├─────────────────────────────────────────┤
│ 📎 Attached: filename.pdf    ❌ Remove  │
│ ┌─────────────────────────────────────┐ │
│ │📎  🎤  [Type instructions...]  Scan│ │
│ └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

---

## 🤖 Chatbot Functions & Features

### 1. **File Upload (📎 Button)**

**What it does:** Attach an invoice document for analysis

**Supported File Types:**
- 📄 **Images**: PNG, JPEG (scanned invoices, photos)
- 📋 **Documents**: PDF, Word (.docx), Excel (.xlsx)
- 📑 **Data Files**: XML, JSON (structured invoice data)

**How to use:**
1. Click the **📎** button in the input area
2. Select your invoice file from your computer
3. Confirmation: "📎 Attached: [filename]" appears
4. To remove: Click the **❌ Remove** button

**Example Use Cases:**
- Upload a PNG photo of a printed invoice
- Upload an Excel file with supplier billing data
- Upload a PDF invoice from email
- Upload XML e-invoice from a system

---

### 2. **Voice Input (🎤 Button)**

**What it does:** Convert spoken words into text instructions

**How to use:**
1. Click the **🎤** button (it will turn red and pulse)
2. Speak your instructions clearly
3. The system transcribes your speech into the text box
4. Click **Scan** or press Enter to send

**Example Voice Commands:**
- "Please verify this invoice for fraud"
- "Extract the supplier name and invoice number"
- "Check if this vendor is registered"

**Requirements:**
- Modern browser with microphone support (Chrome, Firefox, Edge)
- Microphone permissions enabled
- English language (currently set to en-US)

---

### 3. **Text Input (💬 Chat Box)**

**What it does:** Type instructions or submit data corrections

**How to use:**
1. Click in the text input field
2. Type your message or instruction
3. Press **Enter** or click **Scan** button

**What you can type:**
- Corrections to extracted fields
- Special commands (e.g., "CONSOLIDATE")
- Additional invoice details
- Follow-up questions

---

### 4. **Scan Button (🔵 or 💾)**

**What it does:** Submit your invoice/instruction to the AI for processing

**Button States:**
- 🔵 **Blue "Scan"**: Ready to process a new invoice
- 💾 **Orange "Save"**: Appears when chatbot needs you to fix missing fields
- 🔵 **Blue "Scan"**: Returns after you fix and submit the data

**How to use:**
1. Attach a file OR type a message
2. Click **Scan** to send
3. Wait for the chatbot to process (usually 2-10 seconds)

---

## 💬 Chatbot Interaction Workflows

### **Workflow 1: Basic Invoice Upload & Verification** ✅

This is the most common use case—uploading a single invoice for approval.

**Step-by-Step:**

```
1. Navigate to: http://localhost:8080/templates/index.html

2. ATTACH FILE
   └─ Click 📎 → Select invoice.pdf → See "📎 Attached: invoice.pdf"

3. OPTIONAL: ADD VOICE INSTRUCTION
   └─ Click 🎤 → Say "Verify this invoice" → Release microphone

4. SUBMIT
   └─ Click Scan button

5. CHATBOT PROCESSES & RESPONDS
   🔄 Status: "Analyzing document with Z.AI..."
   
   ✅ If approved:
      └─ Shows: "✅ INVOICE APPROVED & LHDN CERTIFIED"
      └─ Displays: All extracted details
      └─ Button: 📄 View / Print Official Certificate
      └─ Contains: LHDN UUID, timestamps, company details
   
   ⚠️ If warnings/unregistered vendor:
      └─ Shows: "⚠️ PENDING REVIEW (UNREGISTERED VENDOR...)"
      └─ Lists: Specific warnings to review
   
   🛑 If fraud detected:
      └─ Shows: "🛑 FRAUD DETECTED (ACTION REQUIRED)"
      └─ Lists: Red flags and violations
```

---

### **Workflow 2: Interactive Data Correction** 🔧

When the AI can't extract critical fields, the chatbot asks you to fill them in.

**Step-by-Step:**

```
1. UPLOAD INVOICE (same as Workflow 1)

2. MISSING DATA DETECTED
   └─ Chatbot: "⚠️ Incomplete Data Detected"
   └─ Shows: List of missing fields (e.g., "Invoice Number", "Supplier Name")
   └─ Button changes to: 💾 Save (orange)

3. USER PROVIDES MISSING DATA
   └─ Type the invoice number in the text box
   └─ Click 💾 Save
   └─ Chatbot: "Got it! Now I just need: **Supplier Name**"

4. REPEAT FOR EACH MISSING FIELD
   └─ Type the supplier name
   └─ Click 💾 Save
   └─ Chatbot: "Got it! Now I just need: **[Next Field]**"
   
   (Continue until all fields are complete)

5. ALL DATA COLLECTED
   └─ Chatbot: "All data collected! Verifying with the database..."
   └─ Button changes back to: 🔵 Scan (blue)
   └─ System re-verifies with all provided data
   └─ Final result displayed (Approved ✅ / Pending ⚠️ / Fraud 🛑)
```

---

### **Workflow 3: Month-End Consolidation** 📦

Aggregate multiple retail cash receipts into a single LHDN-compliant invoice.

**Step-by-Step:**

```
1. THROUGHOUT THE MONTH
   └─ Upload daily retail receipts (B2C transactions)
   └─ Each receipt stored as "PENDING_CONSOLIDATION" status
   
2. END OF MONTH
   └─ Type: "CONSOLIDATE" (case-insensitive)
   └─ Click: Scan button

3. SYSTEM PROCESSES
   ✅ Chatbot: "📦 MONTH-END CONSOLIDATION COMPLETE"
   
4. RESULTS DISPLAYED
   └─ **Receipts Aggregated**: Count of all daily receipts
   └─ **Consolidated Value**: Total amount (RM) of all receipts
   └─ **Master Invoice No**: Unique consolidation ID (CONSOL-YYYYMMDD-HHMM)
   └─ **LHDN Bridge UUID**: Official identifier for LHDN submission
   
5. DOWNLOAD CERTIFICATE
   └─ Click: 📄 View / Print Official Certificate
   └─ Shows: Aggregated invoice details
   └─ Actions: Print to PDF or save as document
```

---

### **Workflow 4: Help & Small Talk** 💬

When you need help or want to test the system.

**Available Commands:**
```
User says:              Chatbot response:
─────────────────────────────────────────────
"Hi"                    Shows help message about uploading invoices
"Hello"                 Shows help message about uploading invoices
"How are you?"          Shows help message about uploading invoices
"Test"                  Shows help message about uploading invoices
"Help"                  Shows help message about uploading invoices
"Ping"                  Shows help message about uploading invoices
```

**Response:**
```
"Hello! I am the LHDN Fraud Detective Agent. To avoid system waste, 
I strictly process procurement data. Please upload an e-invoice 
(Image, XML, Word, or Excel) to begin."
```

---

## 📊 Chatbot Response Types & Meanings

### **Response Status Headers**

| Status | Meaning | Action Required |
|--------|---------|-----------------|
| ✅ **INVOICE APPROVED & LHDN CERTIFIED** | Invoice passed all checks | Download certificate ✓ |
| ⚠️ **PENDING REVIEW** | Vendor unregistered or unknown SKUs | Review warnings, approve manually |
| 🛑 **FRAUD DETECTED** | Red flags identified | Reject invoice, investigate |
| 🛒 **CASH RECEIPT LOGGED** | B2C transaction recorded | Wait for month-end consolidation |
| ⏳ **PENDING CONSOLIDATION** | Receipt waiting for month-end | No action needed |

---

### **Verification Summary Elements**

Each response includes verification checks:

**✅ Checkmarks (Green):**
- Vendor is registered in database
- TIN/SSM numbers match
- No duplicate invoices found
- No overbilling detected
- Invoice successfully bridged to LHDN

**⚠️ Warnings (Yellow):**
- Unregistered vendor (not in database)
- Unknown product SKUs
- Legacy invoice (no LHDN UUID)
- Incomplete vendor information

**🛑 Red Flags (Red):**
- Duplicate invoice detected
- Blacklisted vendor
- Invalid TIN format
- Suspicious pricing patterns
- Overbilling detected

---

## 📥 Input Examples

### **Example 1: Simple Invoice Upload**
```
User Action:
1. Click 📎 → Select "invoice_2026_04.pdf"
2. Click Scan

Chatbot Response:
✅ INVOICE APPROVED & LHDN CERTIFIED

• Supplier Name: DELL GLOBAL BUSINESS CENTER
• Invoice Number: INV-2026-04-001
• Grand Total: RM 13,500.00
• LHDN UUID: a1b2c3d4-e5f6-47g8-h9i0-j1k2l3m4n5o6

[📄 View / Print Official Certificate]
```

---

### **Example 2: Missing Data Interactive Correction**
```
User Action:
1. Click 📎 → Select "unclear_receipt.jpg" (bad photo quality)
2. Click Scan

Chatbot Response:
⚠️ INCOMPLETE DATA DETECTED

Missing fields:
• Invoice Number
• Supplier Name

User Types:
"INV-2026-04-555"
Click 💾 Save

Chatbot:
"Got it! Now I just need: **Supplier Name**"

User Types:
"ACME CORPORATION SDN BHD"
Click 💾 Save

Chatbot:
"All data collected! Verifying with the database..."
[Processing...]

Chatbot Response:
✅ INVOICE APPROVED & LHDN CERTIFIED
[Details displayed...]
```

---

### **Example 3: Fraud Detection**
```
User Action:
1. Click 📎 → Select "duplicate_invoice.pdf"
2. Click Scan

Chatbot Response:
🛑 FRAUD DETECTED (ACTION REQUIRED)

Red Flags:
• ⚠️ DUPLICATE INVOICE: This invoice was already submitted on 2026-04-02
• ⚠️ SUSPICIOUS OVERBILLING: Unit price 300% above average for this product

System Checks:
❌ Database found duplicate entry
⚠️ Vendor 'XYZ Supplies' has 5 flagged invoices this month
```

---

## 🎤 Voice & Accessibility Features

### **Voice Command Examples**

Try speaking these phrases:

```
"Analyze this invoice"
"Check for fraud"
"Verify the supplier"
"Extract the total amount"
"Is this vendor registered?"
"What does the certificate say?"
```

### **Accessibility Notes**

- 🔊 Voice is English (en-US) only
- 🎯 Works on desktop/tablet with microphone
- ⚠️ Mobile browser support varies (test first)
- 📱 Works best on Chrome, Firefox, Microsoft Edge

---

## 📄 Certificate Generation & Download

### **When Certificates Appear**

Certificates are generated automatically when:
- ✅ Invoice is **APPROVED** with no red flags
- 📦 Month-end **CONSOLIDATION** is complete

### **How to Download**

```
1. Look for green button: 📄 View / Print Official Certificate
2. Click the button
3. Browser action:
   └─ Opens new tab with HTML certificate
   └─ Shows all invoice details + LHDN UUID
   
4. Download/Print options:
   └─ Print: Ctrl+P → Save as PDF
   └─ Save HTML: Ctrl+S → Save page locally
   └─ Screenshot: Print screen → Paste into image editor
```

### **Certificate Contents**

```
═══════════════════════════════════════════
  UM Hackathon 2026
  Automated e-Invoice Clearing House
═══════════════════════════════════════════

✅ INVOICE APPROVED & LHDN CERTIFIED

Transaction Details:
─────────────────────────────────────────
Invoice Number:        INV-2026-04-001
Supplier Name:         DELL GLOBAL BUSINESS CENTER
Supplier SSM/TIN:      199501037533 / C1234567890
Buyer Name:            [Company Name]
Grand Total:           RM 13,500.00
Approval Timestamp:    2026-04-25 14:30:45

Official LHDN Bridge Data:
─────────────────────────────────────────
LHDN UUID:             a1b2c3d4-e5f6-47g8-h9i0-j1k2l3m4n5o6

═══════════════════════════════════════════
```

---

### **Basic Workflow: Upload & Verify an Invoice**

1. **Open the Frontend**
   - Navigate to: `http://localhost:8080/templates/index.html`

2. **Upload a Document**
   - Click the 📎 button to attach a file (image, PDF, Word, Excel, XML, JSON)
   - Optionally use the 🎤 button to add verbal instructions
   - Click **Scan** to process

3. **Review Results**
   - The system will display:
     - ✅ Status (Approved, Pending, or Fraud Detected)
     - 📋 Extracted invoice details
     - ⚠️ Any warnings or fraud flags
     - 🔍 Vendor verification status

4. **Approve or Fix**
   - If data is missing, fill in the required fields
   - Click **Save** to submit corrections
   - If approved, download the official certificate via the **📄 View / Print Certificate** button

### **Special Operations**

**Month-End Cash Receipt Consolidation:**
```
1. Upload multiple retail receipts throughout the month
2. Type "CONSOLIDATE" in the chat box
3. System aggregates all pending receipts into a single LHDN-compliant invoice
4. Click **📄 View / Print Certificate** for the master invoice
```


---

## 🚀 Chatbot Quick Reference Guide

### **Button Guide**

| Button | Icon | Function | Color | When to Use |
|--------|------|----------|-------|------------|
| Attach File | 📎 | Upload invoice document | Gray | Before scanning a new invoice |
| Microphone | 🎤 | Voice input for instructions | Orange | To dictate corrections or commands |
| Input Box | 💬 | Type text instructions | White/Blue | To enter missing data or commands |
| Scan/Save | 🔵/💾 | Submit invoice or data | Blue/Orange | After attaching file or filling missing data |
| Remove | ❌ | Delete attached file | Red | If you select the wrong file |
| Certificate | 📄 | Download approval certificate | Green | After invoice is approved ✅ |

---

### **Chatbot Decision Tree**

```
START → Upload File or Type Message
  │
  ├─→ File Upload
  │   └─→ AI Extraction begins
  │       ├─→ All fields extracted ✓
  │       │   └─→ Fraud Check
  │       │       ├─→ No fraud ✅ → APPROVED (Show Certificate)
  │       │       ├─→ Warnings only ⚠️ → PENDING REVIEW
  │       │       └─→ Fraud detected 🛑 → FRAUD ALERT
  │       │
  │       └─→ Missing critical fields
  │           └─→ ASK USER → Input 1 field at a time
  │               └─→ All fields collected
  │                   └─→ Final Fraud Check
  │                       ├─→ APPROVED ✅
  │                       ├─→ PENDING ⚠️
  │                       └─→ FRAUD 🛑
  │
  ├─→ Type "CONSOLIDATE"
  │   └─→ Aggregate retail receipts
  │       └─→ CONSOLIDATION COMPLETE 📦
  │           └─→ Show Master Invoice Certificate
  │
  └─→ Small Talk (Hi, Hello, Test, etc.)
      └─→ Show Help Message
```

---

### **Chatbot Commands Cheat Sheet**

```
Command              Purpose                    Example
─────────────────────────────────────────────────────────────
CONSOLIDATE          End-of-month receipt      Type: "CONSOLIDATE"
                     aggregation                Click: Scan

FINAL_DATA:          Submit corrected          (Automatic when fixing
{json}               invoice data              missing fields)

Hi / Hello /         Get help message          Type: "Hi"
Test / Ping          about system              Click: Scan

Regular Text         Correct missing fields    Type: "INV-2026-001"
                     one at a time             Click: Save
```

---

## 🎯 Common Scenarios & Solutions

### **Scenario 1: Perfect Invoice Upload (Happy Path)** ✅

```
What happens: Your invoice is perfectly readable, all data clear
Time required: 2-5 seconds
What you see: ✅ INVOICE APPROVED & LHDN CERTIFIED
Next step: Click 📄 to download certificate
```

**Tips for success:**
- Upload clear, high-resolution images
- Ensure all required fields are visible (Supplier Name, Invoice #, Total)
- Use PDF or image files for best results

---

### **Scenario 2: Blurry/Unclear Invoice Photo** 📸

```
What happens: AI extracts most data but misses critical fields
Time required: 5-10 seconds (+ manual correction time)
What you see: ⚠️ INCOMPLETE DATA DETECTED
              Missing: [Invoice Number]
              
Your action: Type the missing information
            Click 💾 Save
```

**Tips for better results:**
- Take photos in good lighting
- Keep invoice parallel to camera
- Ensure text is sharp and readable
- Avoid shadows and reflections

---

### **Scenario 3: Unregistered Vendor Warning** ⚠️

```
What happens: Vendor not found in LHDN database
Time required: 2-5 seconds
What you see: ⚠️ PENDING REVIEW (UNREGISTERED VENDOR)
              ⚠️ UNREGISTERED VENDOR: SSM 12345678 not in database
              
Your action: Review warning and approve/reject manually
```

**What to do:**
- Verify vendor details independently
- Cross-reference with LHDN database
- Contact vendor for registration proof
- Approve if legitimate, reject if suspicious

---

### **Scenario 4: Fraud Detected! 🛑**

```
What happens: Invoice matches fraud pattern
Time required: 2-5 seconds
What you see: 🛑 FRAUD DETECTED (ACTION REQUIRED)
              Red Flags:
              • DUPLICATE INVOICE: Already submitted on 2026-04-02
              • Vendor 'XYZ' is BLACKLISTED
              
Your action: DO NOT approve - Investigate immediately
```

**What to do:**
- Note the fraud reason
- Report to compliance team
- Archive evidence (screenshot/PDF)
- Contact vendor if legitimate error

---

### **Scenario 5: Voice Command Not Working** 🎤

```
What happens: Microphone button clicked but nothing happens
Causes: Browser permission, no microphone, unsupported browser

Solutions:
1. Check microphone is connected
2. Grant permission when browser asks
3. Try Chrome/Firefox/Edge instead
4. Type manually instead
```

---

### **Scenario 6: Attachment Fails to Load** ❌

```
What happens: Selected file not appearing after clicking 📎
Causes: Large file, unsupported format, browser issue

Solutions:
1. Check file format (PDF, PNG, JPEG, DOCX, XLSX, XML, JSON only)
2. Try smaller file size (< 10MB recommended)
3. Refresh page and try again
4. Try different browser
```

---

## 💡 Tips & Best Practices

### **For Invoice Uploaders:**

✅ **DO:**
- Upload clear, well-lit invoice photos
- Use PDF files when available
- Provide complete invoice information
- Follow AI prompts for missing data
- Review results before approving

❌ **DON'T:**
- Upload blurry or partially cut-off images
- Submit sensitive personal information
- Upload unrelated documents
- Skip required field corrections
- Approve invoices with red fraud flags

### **For System Administrators:**

✅ **DO:**
- Run database setup before first use
- Keep both terminals (API + HTTP server) running
- Monitor ILMU API for timeouts
- Back up SQLite database regularly
- Review fraud flags before processing

❌ **DON'T:**
- Keep API key hardcoded in production
- Use SQLite for production (migrate to PostgreSQL)
- Allow CORS from all origins in production
- Process invoices without fraud checks
- Ignore timeout warnings

---

## 🔍 What the Chatbot Checks

### **Vendor Verification**
- ✓ Is vendor registered in database?
- ✓ Is vendor blacklisted?
- ✓ Do TIN/SSM numbers match?

### **Invoice Verification**
- ✓ Is invoice number unique (not duplicate)?
- ✓ Are all required fields present?
- ✓ Are monetary amounts reasonable?

### **Fraud Detection**
- ✓ Duplicate invoice detection
- ✓ Overbilling patterns
- ✓ Vendor status checks
- ✓ Invalid TIN format detection
- ✓ Suspicious SKU combinations

### **B2B vs B2C Classification**
- ✓ Is there a "Buyer Name"?
- ✓ Is buyer "General Public"?
- ✓ B2B: Invoice processed immediately
- ✓ B2C: Receipt stored for consolidation

---



### Issue: "ModuleNotFoundError: No module named 'fastapi'"

**Solution:**
```bash
pip install -r requirements.txt
pip install python-docx openpyxl PyPDF2 requests
```

---

### Issue: "Address already in use" (Port 8000 or 8080)

**Solution:**
```powershell
# Find and kill the process using the port
Get-Process -Id (Get-NetTCPConnection -LocalPort 8000).OwningProcess | Stop-Process -Force
Get-Process -Id (Get-NetTCPConnection -LocalPort 8080).OwningProcess | Stop-Process -Force
```

---

### Issue: Database File Not Found

**Solution:**
```bash
python setup_db.py
```

---

### Issue: "ILMU API Timeout"

The application retries automatically (up to 2 attempts with 2-second delays). If timeouts persist:
- Check your internet connection
- Verify the ILMU API key in `main.py` is valid
- The system will continue with manual data entry if AI extraction fails

---

### Issue: CORS Errors in Browser Console

**Solution:**
The application already handles CORS with these settings:
```python
CORSMiddleware(
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

If you still see errors, ensure both servers are running on the correct ports.

---

## 🔐 Security Notes

- ⚠️ **API Key**: The ILMU AI API key is currently hardcoded in `main.py`. For production, move this to environment variables:
  ```bash
  set ILMU_API_KEY=your_key_here
  ```

- ⚠️ **Database**: SQLite is suitable for development. For production, migrate to PostgreSQL or MySQL.

- ⚠️ **CORS**: Current settings allow all origins. Restrict for production:
  ```python
  allow_origins=["https://yourdomain.com"]
  ```

---

## 📊 Database Tables

| Table | Purpose |
|-------|---------|
| **vendors** | Registered company information (SSM, TIN, status) |
| **processed_invoices** | Audit trail of all processed invoices |
| **approved_e_invoices** | Successfully verified invoices with LHDN UUIDs |
| **products** | SKU catalog for overbilling detection |
| **retail_cash_receipts** | Daily B2C transactions pending consolidation |

---

## 💡 Example Test Data

The system comes preloaded with ~100 Malaysian companies (banks, utilities, airlines, retailers, etc.) for testing vendor verification. Check `umhackathon_2026.sql` for the complete vendor list.

---

## 🤝 Contributing

To add new features or fix bugs:

1. Create a new branch
2. Make your changes
3. Test thoroughly with `python test_api.py`
4. Submit a pull request

---

## 📝 License

UM Hackathon 2026 Project

---

## 📧 Support

For issues or questions:
- Check the **Troubleshooting** section above
- Review `main.py` comments for implementation details
- Test with `test_api.py` for API debugging

---

## 🎯 Key Technologies

- **FastAPI** - Modern web framework for APIs
- **SQLite** - Lightweight database
- **ILMU AI API** - Advanced OCR and document extraction
- **Python-docx** - Word document processing
- **openpyxl** - Excel file handling
- **PyPDF2** - PDF processing
- **HTML5/CSS/JavaScript** - Frontend interface

---

**Happy Invoicing! 🚀**
