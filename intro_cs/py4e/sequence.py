string = ''
count = 0
s = 'wuboobxobjkoboobohu'
nextVal = False
for char in s:
    if nextVal and ((string[-1] == 'b' and char == 'o') or (string[-1] == 'o' and char == 'b')):
        string += char
        continue
    else:
        nextVal = False
        if len(string) % 2 == 0:
            string = string[:-1]
        count += len(string) // 2
        string = ''

    if char == 'b':
        string = char
        nextVal = True

if len(string) % 2 == 0:
    string = string[:-1]
count += len(string) // 2

print('Number of times bob occurs is:', count)
