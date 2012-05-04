import sqlite3;
# from datetime import datetime, date;

fileName = "groceries_01"

# conn = sqlite3.connect('groceries_01.sqlite3')
conn = sqlite3.connect(fileName + '.sqlite3')
c = conn.cursor()
c.execute('drop table if exists groceries')
c.execute('create table groceries(id integer primary key autoincrement, name text, percentage_complete integer, category text)')

def mysplit (string):
    quote = False
    retval = []
    current = ""
    for char in string:
        if char == '"':
            quote = not quote
        elif char == ',' and not quote:
            retval.append(current)
            current = ""
        else:
            current += char
    retval.append(current)
    return retval

# Read lines from file, skipping first line
data = open(fileName + ".csv", "r").readlines()[1:]
for entry in data:
    # Parse values
    vals = mysplit(entry.strip())
    # Insert the row!
    print "Inserting %s..." % (vals[0])
    sql = "insert into groceries values(NULL, ?, ?, ?)"
    c.execute(sql, vals)

# Done!
conn.commit()

# Clean up
c.close()
