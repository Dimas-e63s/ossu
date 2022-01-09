from urllib.request import urlopen
import ssl
from bs4 import BeautifulSoup

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = input('Eneter - ')
if len(url) < 1 :
    url = 'http://py4e-data.dr-chuck.net/comments_1369467.html'
html = urlopen(url, context=ctx).read()
soup = BeautifulSoup(html, 'html.parser')
classValArr= list()


tags = soup('span')
for tag in tags :
    classValArr.append(int(tag.contents[0]))
print(sum(classValArr))    

