import sqlite3
from pathlib import Path

db_path = Path(__file__).parent / 'data' / 'ecommerce.db'
query_path = Path(__file__).parent / 'queries.sql'

if not db_path.exists():
    raise FileNotFoundError('Database not found: ' + str(db_path))

with open(query_path, 'r', encoding='utf-8') as f:
    content = f.read()

queries = [q.strip() for q in content.split(';') if q.strip()]
conn = sqlite3.connect(db_path)
cur = conn.cursor()
for i, query in enumerate(queries, 1):
    try:
        cur.execute(query)
        rows = cur.fetchall()
        print('\n--- query', i, '---')
        if not rows:
            print('no results')
            continue
        print([d[0] for d in cur.description])
        for row in rows[:20]:
            print(row)
        if len(rows) > 20:
            print('... more rows')
    except Exception as e:
        print('error in query', i, e)
conn.close()
