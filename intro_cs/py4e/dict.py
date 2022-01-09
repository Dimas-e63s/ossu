fname = input('Enter File Name: ')
if(len(fname) <= 1) :
    fname = 'test.txt'
dic = dict()
fh = open(fname).read().split()
bigcount = None
bigword = None
for word in fh :
    dic[word] = dic.get(word, 0) + 1
    if bigcount is None :
        bigcount = dic[word]
        bigword = word
    elif bigcount < dic[word] :
        bigcount = dic[word]
        bigword = word
print(sorted([ (v,k) for k,v in dic.items()  ], reverse=True)[:10])
