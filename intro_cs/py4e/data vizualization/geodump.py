import sqlite3
import json
import codecs

conn = sqlite3.connect('geodata.sqlite')
cur = conn.cursor()

cur.execute('select * from Locations')
fhand = codecs.open('where.js', 'w', utf-8)
fhand.write('myData=[\n')
count=0
for row in cur:
    data = str(row[1].decode)
    try: js = json.loads(str(data))
    except: continue

    if not ('status' in js and js['status'] == 'OK'): continue

    lat = js['results'][0]['geometry']['location']['lat']
    lng = js['results'][0]['geometry']['location']['lng']
    if lat == 0 or lng == 0: continue
    where = js['results']['formatted_address']
