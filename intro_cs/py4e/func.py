def compute_pay(hours, rate) :
    try:
        hours = float(hours)
        rate = float(rate)
    except:
        print('Enter a number')
        exit()
    pay = hours * rate
    if hours > 40 :
        pay+= (hours - 40) * (rate * 0.5)  
    return pay   
hours = input('Enter Hours: ')
rate = input('Enter Rate: ')
print('Pay: ', compute_pay(hours, rate))

repeat_lyrics()

def repeat_lyrics():
    print_lyrics()
    print_lyrics()

def print_lyrics():
    print("I'm a lumberjack, and I'm okay.")
    print('I sleep all night and I work all day.')
