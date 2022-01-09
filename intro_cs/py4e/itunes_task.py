import xml.etree.ElementTree as ET
import sqlite3

conn = sqlite3.connect('itunesdb.sqlite')
cur = conn.cursor()

cur.executescript('''
drop table if exists Artist;
drop table if exists Genre;
drop table if exists Album;
drop table if exists Track;

CREATE TABLE Artist (
    id  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    name    TEXT UNIQUE
);

CREATE TABLE Genre (
    id  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    name    TEXT UNIQUE
);

CREATE TABLE Album (
    id  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    artist_id  INTEGER,
    title   TEXT UNIQUE
);

CREATE TABLE Track (
    id  INTEGER NOT NULL PRIMARY KEY 
        AUTOINCREMENT UNIQUE,
    title TEXT  UNIQUE,
    album_id  INTEGER,
    genre_id  INTEGER,
    len INTEGER, rating INTEGER, count INTEGER
);
''')


def lookup(xml_struct, key):
    found = False
    for child in xml_struct:
        if found: return child.text
        if child.tag == 'key' and child.text == key:
            found = True
    return None


fname = 'Library.xml'
fh = open(fname)
data = ET.parse(fh)
for row in data.findall('dict/dict/dict'):
    if lookup(row, 'Track ID') is None: continue

    name = lookup(row, 'Name')
    artist = lookup(row, 'Artist')
    album = lookup(row, 'Album')
    count = lookup(row, 'Play Count')
    rating = lookup(row, 'Rating')
    genre = lookup(row, 'Genre')
    length = lookup(row, 'Total Time')

    if name is None or artist is None or album is None or genre is None: continue


    cur.execute('insert or ignore into Artist (name) values (?)', (artist,))
    cur.execute('select id from Artist where name = ?', (artist,))
    artist_id = cur.fetchone()[0]
    print(genre)
    cur.execute('insert or ignore into Genre (name) values (?)', (genre,))
    print(genre)
    cur.execute('select id from Genre where name = ?', (genre,))
    genre_id = cur.fetchone()[0]
    cur.execute('insert or ignore into Album (artist_id, title) values  (?,?)', (artist_id, album))
    cur.execute('select id from Album where title = ?', (album,))
    print(album)
    album_id = cur.fetchone()[0]
    print(name, album_id, genre_id, length, rating, count)
    cur.execute('insert or replace into Track (title, album_id, genre_id, len, rating, count) values (?,?,?,?,?,?)', (name, album_id, genre_id, length,  rating, count))

    conn.commit()
cur.close()
