import urllib.request, urllib.parse, urllib.error
import xml.etree.ElementTree as ET
import ssl

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = input('Enter a URL: ')
if len(url) < 1:
    url = 'http://py4e-data.dr-chuck.net/comments_1369469.xml'

print('Retrieved', url)
uh = urllib.request.urlopen(url, context=ctx)

data = uh.read()
tree = ET.fromstring(data)
commentsDict = tree.findall('comments/comment')
res = list()

for comment in commentsDict:
    res.append(int(comment.find('count').text))

print(sum(res))

