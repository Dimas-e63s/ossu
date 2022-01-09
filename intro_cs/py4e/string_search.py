str = 'X-DSPAM-Confidence: 0.8475 '
startIdx = str.find(':')
val = str[startIdx + 1:].strip()
print(float(val))

idx = len(str) - 1 
while idx >= 0 :
    print(str[idx])
    idx-=1
