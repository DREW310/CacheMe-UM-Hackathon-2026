#adding table in sqlite database
import sqlite3

# Connect directly to your active hackathon database
conn = sqlite3.connect('umhackathon_2026.db')
cursor = conn.cursor()

# Inject the new table
cursor.execute("""
CREATE TABLE IF NOT EXISTS `retail_cash_receipts` (
  `receipt_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `receipt_number` VARCHAR(100) NOT NULL,
  `transaction_date` DATE NOT NULL,
  `total_amount` DECIMAL(12,2) NOT NULL,
  `status` VARCHAR(50) DEFAULT 'PENDING_CONSOLIDATION'
)
""")

conn.commit()
conn.close()
print("✅ Retail Cash Receipts table added safely!")