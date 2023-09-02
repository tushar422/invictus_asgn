import mysql.connector

mydb = mysql.connector.connect(
    host='localhost',
    user = 'root',
    passwd = 'databasetest',
)

mycursor = mydb.cursor()
# mycursor.execute('create database invictus')
mycursor.execute("SHOW DATABASES")
for db in mycursor:
    print(db)
