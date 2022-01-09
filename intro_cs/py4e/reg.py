import re
fname = 'test.txt'
fh = open(fname)
res = re.findall('([0-9]+)', fh.read())
total = 0
for num in res :
    total += int(num)
print(total)
