# 🚀 E-commerce Sales Analysis (SQL)

## What this is

This is a small SQL project I built to get back to basics and practice working with real data.

The goal was simple: take an e-commerce dataset and answer a few practical questions around revenue, customers, and product performance.

## Dataset

Brazilian E-commerce public dataset (Olist)

Used mainly:

- orders
- order_items
- customers
- products

## What I did

## Data Pipeline ETL

I used Python to build a simple ETL process:

Extracted raw CSV files using pandas
Selected only relevant columns for analysis
Loaded structured data into a SQLite database

This allowed me to run SQL queries directly on a clean local database instead of raw files.

## Quering the data to get basic insights

Wrote a set of SQL queries to explore:

- Total revenue
- Revenue over time (monthly trend)
- Top products by revenue
- Top customers by spending
- Average order value
- Customer order frequency

Nothing complex, just focusing on getting the fundamentals right: joins, group by, aggregations

## Key takeaways

- Revenue is not evenly distributed, a small number of products drive a big share
- Same pattern with customers, a few high spenders stand out clearly
- Breaking things down over time makes trends much easier to see

## Tech used

- SQL (SQLite)

## Why I did this

Coming from a different background, I'm focusing on building solid fundamentals through small, hands-on projects instead of just theory.
