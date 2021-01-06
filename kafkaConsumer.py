from kafka import KafkaConsumer
import sqlite3
from json import loads

conn = sqlite3.connect('/Users/viditb/Desktop/Course Work/Semester 3/ITP/AppEase/AppEasePlatform/backendapi/db.sqlite3')
c = conn.cursor()

consumer = KafkaConsumer(
    'healthData',
     bootstrap_servers=['192.168.0.155:9092'],
     auto_offset_reset='latest',
     value_deserializer=lambda x: x.decode('utf-8')
)


def tableExists(tableName):
    # Getting the count of tables with the name
    queryParameters = (tableName,)
    c.execute("SELECT count(name) FROM sqlite_master WHERE type='table' AND name=?", queryParameters)

    #if the count is 1, then table exists
    if c.fetchone()[0]==1 :
        print(tableName, ' exists.')
        return True
    else :
        print(tableName, ' doesnt exist')
        return False
        

if not tableExists("healthData"):
    c.execute('''create table healthData (
    timeStamp text, userToken text, age integer, sex text, bloodType text,
    heartRate integer, stepsCount integer, distanceCovered real, 
    stationaryLabelCount integer, walkingLabelCount integer, 
    runningLabelCount integer, automotiveLabelCount integer, 
    cyclingLabelCount integer, unknownLabelCount integer)''')

    conn.commit()
    print('Created the health table')

if not tableExists("locationData"):
    c.execute('''create table locationData (timeStamp text, userToken text, longitude real, latitude real)''')
    conn.commit()
    print('Created the location table')

if not tableExists("gameLogData"):
    c.execute('''create table gameLogData (timeStamp text, userToken text, gameStatus text, gameName text)''')
    conn.commit()
    print('Created the game log table')


for message in consumer:
    message = message.value
    try: 
        message = loads(message)
        print(message)
        if "gameStatus" in message.keys():
            columns = ', '.join(message.keys())
            placeholders = ':'+', :'.join(message.keys())
            query = 'INSERT INTO gameLogData (%s) VALUES (%s)' % (columns, placeholders)
            c.execute(query, message)
            conn.commit()
        else:
            locationMessage = {
                "timeStamp": message["timeStamp"],
                "userToken": message["userToken"],
                "longitude": message["longitude"],
                "latitude": message["latitude"]
            }
            columns = ', '.join(locationMessage.keys())
            placeholders = ':'+', :'.join(locationMessage.keys())
            query = 'INSERT INTO locationData (%s) VALUES (%s)' % (columns, placeholders)
            c.execute(query, locationMessage)


            message.pop('longitude', None)
            message.pop('latitude', None)
            columns = ', '.join(message.keys())
            placeholders = ':'+', :'.join(message.keys())
            query = 'INSERT INTO healthData (%s) VALUES (%s)' % (columns, placeholders)
            c.execute(query, message)
            conn.commit()
    except:
        print("Couldnt convert to json")

