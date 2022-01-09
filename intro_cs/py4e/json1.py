import json
data = '''{
  "name": "Chuck",
  "phone": {
    "type": "intl",
    "number": "+1 734 303 4456"
  },
  "email": {
    "hide": "yes"
  }
}'''

input = '''[
 {
   "id": "001",
   "x": "2",
   "name": "Chuck"
 },
 {
   "id": "009",
   "x": "7",
   "name": "Chuck"
 }
]'''

info = json.loads(data)
inputJson = json.loads(input)
#print(info.get('name'))
#print('Name:', info["name"])
#print('Hide:', info["email"]['hide'])

print(inputJson)