from kafka import KafkaConsumer
import sqlite3
from json import loads

conn = sqlite3.connect('/Users/viditb/Desktop/Course Work/Semester 3/ITP/AppEase/AppEasePlatform/backendapi/db.sqlite3')
c = conn.cursor()

consumer = KafkaConsumer(
    'healthData',
     bootstrap_servers=['10.0.0.55:9092'],
     auto_offset_reset='latest',
     value_deserializer=lambda x: x.decode('utf-8')
)

# Getting the count of tables with the name
c.execute(''' SELECT count(name) FROM sqlite_master WHERE type='table' AND name='healthData' ''')

#if the count is 1, then table exists
if c.fetchone()[0]==1 :
    print('Table exists.')
else :
    print('Table doesnt exist')
    
    c.execute('''create table healthData (
    timeStamp text, userToken text, age integer, sex text, bloodType text,
    heartRate integer, stepsCount integer, distanceCovered real, 
    stationaryLabelCount integer, walkingLabelCount integer, 
    runningLabelCount integer, automotiveLabelCount integer, 
    cyclingLabelCount integer, unknownLabelCount integer)''')

    # Add to DB if table doesnt exist
    conn.commit()
    print('Created the table')

for message in consumer:
    message = message.value
    try: 
        message = loads(message)
        print(message)
        columns = ', '.join(message.keys())
        placeholders = ':'+', :'.join(message.keys())
        query = 'INSERT INTO healthData (%s) VALUES (%s)' % (columns, placeholders)
        c.execute(query, message)
        conn.commit()
    except:
        print("Couldnt convert to json")

