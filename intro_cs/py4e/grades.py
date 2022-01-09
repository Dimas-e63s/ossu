class Grades(object):
    def __init__(self):
        self.students = []
        self.grades = {}
        self.isSorted = True

    def addStudent(self, student):
        if student in self.students:
            raise ValueError('Duplicate student')
        self.students.append(student)
        self.grades[student.getIdNum()] = []
        self.isSorted = False

    def addGrade(self, student, grade):
        try:
            self.grades[student.getIdNum()].append(grade)
        except:
             raise ValueError('Student not in grade book')

    def getGrades(self, student):
        try:
            return self.grades[student.getIdNum()][:]
        except KeyError:
            raise ValueError('Student not in grade book')

    def allStudents(self):
        if not self.isSorted:
            self.students.sort()
            self.isSorted = True
        for s in self.students:
            yield s

def gradeReport(course):
    report = []
    for s in course.allStudents():
        tot = 0.0
        numGrades = 0
        for g in course.getGrades(s):
            tot += g
            numGrades += 1
        try:
            average = tot/numGrades
            report.append(str(s) + '\'s mean grade is' + str(average))
        except ZeroDivisionError:
            report.append(str(s) + ' has no grades')
    return '\n'.join(report)