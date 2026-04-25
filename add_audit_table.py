import sqlite3

conn = sqlite3.connect('umhackathon_2026.db')
cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS `audit_logs` (
  `log_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `invoice_number` VARCHAR(100),
  `vendor_name` VARCHAR(255),
  `status` VARCHAR(50),
  `issues_detected` TEXT,
  `processed_at` DATETIME DEFAULT CURRENT_TIMESTAMP
)
""")

conn.commit()
conn.close()
print("✅ Audit Logs table added safely!")