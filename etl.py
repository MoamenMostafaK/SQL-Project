import pandas as pd
import sqlite3
import os


base_path = os.path.dirname(__file__)
db_path = os.path.join(base_path, 'olist_ecommerce.db')

conn = sqlite3.connect(db_path)

# 1. Define Schemas for the questions (Revenue, Top Products, Top Customers)
schemas = {
    'orders': {
        'file': 'olist_orders_dataset.csv',
        'cols': ['order_id', 'customer_id', 'order_purchase_timestamp', 'order_status']
    },
    'order_items': {
        'file': 'olist_order_items_dataset.csv',
        'cols': ['order_id', 'product_id', 'price', 'freight_value']
    },
    'customers': {
        'file': 'olist_customers_dataset.csv',
        'cols': ['customer_id', 'customer_unique_id'] # unique_id is key for "Frequent Customers"
    },
    'products': {
        'file': 'olist_products_dataset.csv',
        'cols': ['product_id', 'product_category_name']
    }
}

# 2. Import everything
for table_name, info in schemas.items():
    file_path = os.path.join(base_path, info['file'])
    
    if os.path.exists(file_path):
        df = pd.read_csv(file_path, usecols=info['cols'])
        # 'replace' handles the "delete if exists" requirement
        df.to_sql(table_name, conn, if_exists='replace', index=False)
        print(f"Table '{table_name}' updated successfully.")
    else:
        print(f"Warning: {info['file']} not found in {base_path}")

print("\nDatabase is ready for analysis.")
conn.close()
