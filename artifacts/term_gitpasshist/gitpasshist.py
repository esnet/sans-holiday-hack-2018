# uncompyle6 version 2.11.5
# Python bytecode 3.5 (3351)
# Decompiled from: Python 3.6.7 (default, Oct 22 2018, 11:32:17) 
# [GCC 8.2.0]
# Embedded file name: gitpasshist.py
# Compiled at: 2017-11-16 12:09:38
# Size of source mod 2**32: 1323 bytes
import json
import sys
import os
import time
import signal
from hashlib import sha256
import hmac

def calcHmac(secret, resourceId):
    return hmac.new(secret.encode('utf8'), resourceId.encode('utf8'), sha256).hexdigest()


def printResponse(hash, resourceId):
    print('#####hhc:%s#####' % json.dumps({'hash': hash,
     'resourceId': resourceId}))


def signal_handler(signal, frame):
    print('')
    sys.exit(0)


def errorandexit(msg2):
    error = "\nI'm very sorry, but we seem to have an internal issue preventing the successful\ncompletion of this challenge. Please email support@holidayhackchallenge.com with\na screen-shot or any other details you can provide. Thank you!\n\n"
    print(error)
    if msg2 != '':
        print(msg2)
    sys.exit(-1)


if __name__ == '__main__':
    debuggin = False
    r = None
    signal.signal(signal.SIGINT, signal_handler)
try:
    RESOURCEID = os.environ.get('RESOURCE_ID')
    if RESOURCEID == '' or RESOURCEID == None:
        errorandexit('Unable to obtain resource ID information.')
    if debuggin:
        print('\nRESOURCEID = ' + RESOURCEID)
    key = '32f7f08dbb014bb3a288ecc9ecce1486'
    h = hmac.new(key.encode('utf8'), RESOURCEID.encode('utf8'), sha256)
    payload = {'hash': h.hexdigest(),'resourceid': RESOURCEID}
    sys.stdout.write('Loading, please wait.')
    sys.stdout.flush()
    for i in range(0, 5):
        if not debuggin:
            time.sleep(1)
        sys.stdout.write('.')
        sys.stdout.flush()

    print('\n')
    guess = input("\n\nEnter Sparkle Redberry's password: ")
    if guess.lower() == 'twinkletwinkletwinkle':
        hmac256 = calcHmac(key, RESOURCEID)
        printResponse(hmac256, RESOURCEID)
        time.sleep(0.5)
        print('\nThis ain\'t "I told you so" time, but it\'s true:\nI shake my head at the goofs we go through.\nEveryone knows that the gits aren\'t the place;\nStore your credentials in some safer space.\n\nCongratulations!\n')
    else:
        print("I'm sorry, that is not the right answer.\n")
except Exception as e:
    errorandexit(str(e))
    sys.exit(0)
# okay decompiling gitpasshist.extracted.pyc
