hours = input('Enter Hours: ')
rate = input('Enter Rate: ')
hours = float(hours)
rate = float(rate)
pay = hours * rate
if hours > 40 :
     pay+= (hours - 40) * (rate * 0.5)  
print('Pay: ', pay)


