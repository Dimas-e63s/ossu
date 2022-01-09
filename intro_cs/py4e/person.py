import datetime


class Person(object):
    def __init__(self, name):
        self.name = name
        self.birthday = None
        self.lastName = name.split(' ')[-1]

    def getLastName(self):
        return self.lastName

    def setBirthday(self, month, day, year):
        self.birthday = datetime.date(year, month, day)

    def getAge(self):
        if self.birthday is None:
            raise ValueError
        return (datetime.date.today() - self.birthday).days

    def __str__(self):
        return self.name

    def __lt__(self, other):
        if self.lastName == other.lastName:
            return self.name < other.name
        return self.lastName < other.lastName


class MITPerson(Person):
    _nextIdNum = 0

    def __init__(self, name):
        Person.__init__(self, name)
        self.idNum = MITPerson.nextIdNum
        MITPerson.nextIdNum += 1

    def getIdNum(self):
        return self.idNum

    def __lt__(self, other):
        return self.idNum < other.idNum

    def speak(self, utterance):
        return (self.getLastName() + " says: " + utterance)


class UG(MITPerson):
    def __init__(self,name,classYear):
        MITPerson.__init__(name)
        self.year = classYear

    def getClass(self):
        return self.year

    def speak(self, utterance):
        return MITPerson.speak(self, " Dude " + utterance)


class Grad(MITPerson):
    pass


class Professor(MITPerson):
    def __init__(self, name, department):
        MITPerson.__init__(name)
        self.department = department

    def speak(self, utterance):
        new = 'In course ' + self.department + ' we say'
        return MITPerson.speak(self, new + utterance)

    def lecture(self, topic):
        return self.speak('it is obvious that ' + topic)

def isStudent(obj):
    return isinstance(obj, UG) or isinstance(obj, Grad)

mit = MITPerson('John')
mit2 = MITPerson('Claar')

print(mit2.idNum)