import sqlite3
import re

conn = sqlite3.connect('emaildb.sqlite')
cur = conn.cursor()

cur.executescript('''
drop table if exists Counts;
create table Counts (org text, count integer)
''')

fname = 'mbox.txt'
fh = open(fname)

for line in fh:
    if not re.findall('^From: ', line) : continue
    org = re.findall('\S+@(\S+)', line)[0]
    print(org)
    cur.execute('select org from Counts where org = ?', (org,))
    row = cur.fetchone()
    if row is None:
        cur.execute('insert into Counts (org, count) values (?, 1)', (org,))
    else:
        cur.execute('update Counts SET count = count + 1 where org = ?', (org,))
    conn.commit()
cur.close()
