import pandas as pd
import sqlite3
from pathlib import Path

data_dir = Path(__file__).parent / 'data'
db_path = data_dir / 'ecommerce.db'
files = {
    'orders': ('olist_orders_dataset.csv', ['order_id', 'customer_id', 'order_purchase_timestamp', 'order_status']),
    'order_items': ('olist_order_items_dataset.csv', ['order_id', 'product_id', 'price', 'freight_value']),
    'customers': ('olist_customers_dataset.csv', ['customer_id', 'customer_unique_id']),
    'products': ('olist_products_dataset.csv', ['product_id', 'product_category_name']),
}

data_dir.mkdir(exist_ok=True)
conn = sqlite3.connect(db_path)
for table, (file_name, cols) in files.items():
    path = data_dir / file_name
    if not path.exists():
        raise FileNotFoundError(f'{file_name} not found in data/')
    df = pd.read_csv(path, usecols=cols)
    df.to_sql(table, conn, if_exists='replace', index=False)
    print('loaded', len(df), 'rows into', table)
conn.close()
print('database ready:', db_path)
