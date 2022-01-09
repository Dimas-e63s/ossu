import urllib.request, urllib.parse, urllib.error
import json

serviceUrl = 'http://maps.googleapis.com/maps/api/geocode/json?'

while True :
    address = input('Enter locataion: ')
    if len(address) < 1 : break

    url = serviceUrl + urllib.parse.urlencode(
        {'address': address}
    )
    print('Retrieving', url)
    uh = urllib.request.urlopen(url)
    data = uh.read().decode()
    print('Retrieved', len(data), 'characters')

    try:
        js = json.loads(data)
    except:
        js = None

    if not js or 'status' not in js or js.get('status') != 'OK' :
        print('==== Failure To Retrieve ====')
        print(data)
        continue

    print(json.dumps(js, indent=4))
    location = js.get('results')[0].get('geometry').get('location')
    lat = location.get('lat')
    lng = location.get('lng')
    print('lat', lat, 'lng',lng)
