import urllib.request, urllib.parse, urllib.error
import json
import ssl

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = input('Enter a URL: ')
if len(url) < 1:
    url = 'http://py4e-data.dr-chuck.net/comments_1369470.json'

res = urllib.request.urlopen(url, context=ctx)
res = res.read().decode()
res = json.loads(res).get('comments')
total = 0

for item in res:
    total += int(item.get('count'))

print(total)