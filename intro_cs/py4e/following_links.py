import urllib.request, urllib.parse, urllib.error
from bs4 import BeautifulSoup
import ssl

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = input('Enter URL: ')
if len(url) < 1 :
    url = 'http://py4e-data.dr-chuck.net/known_by_Amaan.html'
count = input('Enter count: ')
pos = input('Enter position: ')

for i in range(int(count)+1) :
    html = urllib.request.urlopen(url, context=ctx).read()
    soup = BeautifulSoup(html, 'html.parser')
    tags = soup('a')
    num =1
    print('Retrieving:', url) 
    for tag in tags :
        if int(pos) == num :
            url = tag.get('href', None)
            num =1 
            break
        num+=1
        continue
       
