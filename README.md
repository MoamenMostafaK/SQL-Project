# E-commerce SQL project

This is a simple project using the Olist public e-commerce dataset downloaded from Kaggle.com
I cleaned the CSV files, loaded the tables into SQLite, and wrote a few SQL queries to check revenue, categories, and customer behavior.

## Files

- `etl.py` — load the data into `data/ecommerce.db`
- `run_queries.py` — run the queries in `queries.sql`
- `queries.sql` — the SQL analysis
- `data/` — source CSV files and the database file

## Setup

- Install Python 3.10 or newer.
- Install dependencies:

  ```bash
  pip install -r requirements.txt
  ```

## Run it

```bash
python etl.py
python run_queries.py
```

## What I looked at

- total revenue and freight
- revenue by month
- category revenue share
- top customers by spending
- order value min/avg/max
- customer order frequency

If you want, open `queries.sql` and run the queries directly.

## Screenshots are available in /screenshots