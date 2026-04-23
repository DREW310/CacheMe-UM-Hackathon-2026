import sqlite3
import os

def build_database():
    db_name = 'umhackathon_2026.db'
    
    # Remove the old database if it exists so we start fresh every time we run this
    if os.path.exists(db_name):
        os.remove(db_name)
        print("🗑️ Removed old database.")

    # Connect to (and create) the new SQLite database
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()

    print("🔨 Building SQLite database tables...")

    # We use SQLite syntax here (INTEGER PRIMARY KEY AUTOINCREMENT)
    schema = """
    PRAGMA foreign_keys = ON;

    -- 1. VENDORS TABLE
    CREATE TABLE vendors (
        vendor_id INTEGER PRIMARY KEY AUTOINCREMENT,
        company_name TEXT NOT NULL,
        ssm_number TEXT NOT NULL UNIQUE,
        tax_id TEXT NOT NULL,
        status TEXT DEFAULT 'ACTIVE'
    );

    -- 2. PRODUCTS TABLE
    CREATE TABLE products (
        sku TEXT PRIMARY KEY,
        product_name TEXT NOT NULL,
        category TEXT
    );

    -- 3. CONTRACTS TABLE
    CREATE TABLE vendor_contracts (
        contract_id INTEGER PRIMARY KEY AUTOINCREMENT,
        vendor_id INTEGER NOT NULL,
        sku TEXT NOT NULL,
        agreed_unit_price REAL NOT NULL,
        valid_until TEXT NOT NULL,
        FOREIGN KEY (vendor_id) REFERENCES vendors (vendor_id),
        FOREIGN KEY (sku) REFERENCES products (sku)
    );

    -- 4. PROCESSED INVOICES TABLE
    CREATE TABLE processed_invoices (
        invoice_id INTEGER PRIMARY KEY AUTOINCREMENT,
        invoice_number TEXT NOT NULL,
        vendor_id INTEGER NOT NULL,
        total_amount REAL NOT NULL,
        processed_date DATETIME DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (invoice_number, vendor_id),
        FOREIGN KEY (vendor_id) REFERENCES vendors (vendor_id)
    );
    """
    
    cursor.executescript(schema)

    print("💉 Injecting top company and contract data...")

    # Insert Data
    cursor.executescript("""
    INSERT INTO vendors (company_name, ssm_number, tax_id, status) VALUES
    ('Dell Global Business Center Sdn Bhd', '199501037533', 'C1234567890', 'ACTIVE'),
    ('Telekom Malaysia Berhad', '198401016183', 'C9876543210', 'ACTIVE'),
    ('SNS Network (M) Sdn Bhd', '199801015502', 'C5554443330', 'ACTIVE'),
    ('Petronas Dagangan Berhad', '198201004151', 'C1112223330', 'ACTIVE');

    INSERT INTO products (sku, product_name, category) VALUES
    ('SKU-DELL-L5450', 'Dell Latitude 5450 Business Laptop', 'IT Hardware'),
    ('SKU-DELL-S150', 'Dell PowerEdge T150 Server', 'IT Hardware'),
    ('SKU-TM-ENT800', 'Enterprise Fibre 800Mbps (Monthly)', 'Networking'),
    ('SKU-CISCO-9200', 'Cisco Catalyst 9200L-48P-4G Switch', 'Networking'),
    ('SKU-PET-DSL', 'Diesel - Fleet Card (Per Liter)', 'Fuel');

    INSERT INTO vendor_contracts (vendor_id, sku, agreed_unit_price, valid_until) VALUES
    (1, 'SKU-DELL-L5450', 4500.00, '2026-12-31'),
    (1, 'SKU-DELL-S150', 6200.00, '2026-12-31'),
    (2, 'SKU-TM-ENT800', 349.00, '2026-12-31'),
    (3, 'SKU-CISCO-9200', 8500.00, '2026-12-31'),
    (4, 'SKU-PET-DSL', 2.15, '2026-12-31');

    INSERT INTO processed_invoices (invoice_number, vendor_id, total_amount, processed_date) VALUES
    ('INV-2026-04-001', 1, 13500.00, '2026-04-02 09:15:00'),
    ('TM-B-449211', 2, 349.00, '2026-04-05 14:30:00'),
    ('SNS-INV-8832', 3, 17000.00, '2026-04-10 11:45:00');
    """)

    conn.commit()
    conn.close()
    print(f"✅ Success! {db_name} has been created and populated.")

if __name__ == "__main__":
    build_database()