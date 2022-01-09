def askForNum() :
    return input('Enter a number: ')

total = 0
count = 0
while True :
    val = askForNum()
    if val == 'done' :
        print(total, count, total / count)
        break
    count += 1
    try:
        val = float(val)
    except:
        print('Invalid input')
        continue
    total+= val
