hours = input('Enter Hours: ')
try: 
    hours = float(hours)
except:
    print('Error, please enter numeric input')   
    exit()
rate = input('Enter Rate: ')
try:
    rate = float(rate)
except:
    print('Error, please enter numeric value')
    exit()
pay = hours * rate
if hours > 40 :
     pay+= (hours - 40) * (rate * 0.5)  
print('Pay: ', pay)


