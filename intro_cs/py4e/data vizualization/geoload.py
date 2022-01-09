import urllib.request, urllib.parse, urllib.error
import sqlite3
import http
import json
import time
import ssl
import sys

service_url = 'https://py4e-data.dr-chuck.net/geojson?'

conn = sqlite3.connect('geodata.sqlite')
cur = conn.cursor()

cur.execute('create table if not exists Locations (address text, geodata text)')

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

fh = open('where.data')
count = 0
for line in fh:
    if count > 200 :
        print('Retrieved 200 locations, restart to retrieve more')
        break

    address = line.strip()
    print('')
    cur.execute('select geodata from Locations where address =?', (memoryview(address.encode()),))

    try:
        data = cur.fetchone()[0]
        print('Found in database', address)
        continue
    except:
        pass

    parms = dict()
    parms["query"] = address
    url = service_url + urllib.parse.urlencode(parms)

    print('Retrieving', url)
    uh = urllib.request.urlopen(url, context=ctx)
    data = uh.read().decode()
    print('Retrieved', len(data), ' characters', data[:20].replace('\n', ' '))
    count += 1

    try:
        js = json.loads(data)
    except:
        print(data)
        continue

    if 'status' not in js or (js['status'] != 'OK' and js['status' != 'ZERO_RESULTS']) :
        print('=== Failure To Retrieve ===')
        print(data)
        break

    cur.execute('insert into Locations (address, geodata) values (?,?)', (memoryview(address.encode()), memoryview(data.encode())))
    conn.commit()

    if count % 10 == 0 :
        print('Pausing for a bit...')
        time.sleep(5)

print("Run geodump.py to read the data from the database so you can vizualize it on a map.")
