import sys
import json
import datetime

now = datetime.datetime.now()

if name == “__main__“:
    if len (sys.argv) > 1:
        print (sys.argv[1] * 2)
        date = now.strftime(“%m/%d/%Y”)
        time = now.strftime(“%H:%M:%S”)
        value = sys.argv[1]
        data = {}
        data[‘script’] = []
        data[‘script’].append({
            “date” : date,
            “time” : time,
            “value” : value
        })

        with open(“JOURNAL.json”, “w”) as write_file:
            json.dump(data, write_file)
    else:
        print (“Скрипт надо вызывать с параметром - число“)
