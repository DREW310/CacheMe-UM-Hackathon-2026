import sqlite3

# Connect directly to your active hackathon database
conn = sqlite3.connect('umhackathon_2026.db')
cursor = conn.cursor()

# Inject the approved e-invoices ledger safely
cursor.execute("""
CREATE TABLE IF NOT EXISTS `approved_e_invoices` (
  `approval_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `invoice_number` VARCHAR(100) NOT NULL,
  `supplier_ssm` VARCHAR(50) NOT NULL,
  `buyer_name` VARCHAR(255) NOT NULL,
  `grand_total` DECIMAL(12,2) NOT NULL,
  `lhdn_uuid` VARCHAR(100) NOT NULL,
  `approved_time` DATETIME NOT NULL
)
""")

conn.commit()
conn.close()
print("✅ Approved e-Invoices table added safely!")