import sqlite3
import json

conn = sqlite3.connect('roster_data.sqlite')
cur = conn.cursor()

cur.executescript('''
drop table if exists User;
drop table if exists Course;
drop table if exists Member;

create table User (
  id integer not null primary key autoincrement unique,
  name text unique
);

create table Course (
  id integer not null primary key autoincrement unique,
  title text unique 
);

create table Member (
  user_id integer,
  course_id integer,
  role integer,
  primary key (user_id, course_id)
);
''')

fname = 'roster_data.json'
fh = open(fname).read()

for entry in json.loads(fh):
    name = entry[0]
    course = entry[1]
    role = entry[2]

    cur.execute('insert or ignore into User (name) values (?)', (name,))
    cur.execute('select id from User where name = ?', (name,))
    user_id = cur.fetchone()[0]

    cur.execute('insert or ignore into Course (title) values (?)', (course,))
    cur.execute('select id from Course where title = ?', (course,))
    course_id = cur.fetchone()[0]

    cur.execute('insert or replace into Member (user_id, course_id, role) values (?,?,?)', (user_id, course_id, role))
    conn.commit()

cur.close()
