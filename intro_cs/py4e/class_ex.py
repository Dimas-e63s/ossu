class PartyAnimal:
    x = 0

    def __init__(self):
        print('I am constructed')

    def party(self):
        self.x += 1
        print('So far', self.x)

    def __del__(self):
        print('I am get deleted')


an = PartyAnimal()
an.party()
an.party()

print(an.x)

# x = PartyAnimal()
# print(x.x)
