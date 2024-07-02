import psycopg2
import psycopg2.extras

host = "localhost"
dbname =  "dictdb"
port = 5432
user = "postgres"	
conn = None

def db_connection():
    return psycopg2.connect()

def read_dict():
    dbconn = db_connection()
    cur = dbconn.cursor()
    cur.execute("SELECT id, word, translation FROM dictionary;")
    rows = cur.fetchall()
    cur.close()
    dbconn.close()
    return rows


while True: ## REPL - Read Execute Program Loop
    cmd = input("Command: ")

    if cmd == "list":
        print('rows')
        
    elif cmd == "quit":
        exit()
    else:
        print("error")