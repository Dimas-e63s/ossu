x = 8
low = 0.0
high = 100
epsilon = 0.1
ans = (high+low) / 2.0
print('Please think of a number between 0 and 100!')

while True:
    print('Is your secret number', int(ans), end='')
    print('?')

    guess = input(
        'Enter \'h\' to indicate the guess is too high. Enter \'l\' to indicate the guess is too low. Enter \'c\' to indicate I guessed correctly.')
    if not guess in ['h', 'l', 'c']:
        print('Sorry, I did not understand your input.')
        continue
    elif guess == 'h':
        high = ans
    elif guess == 'l':
        low = ans
    else:
        print('Game over. Your secret number was:', ans)
        break
    ans = (high+low) // 2.0
