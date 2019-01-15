#!/usr/bin/env python

import requests

for key in ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'Ash', 'Csh' 'Dsh', 'Fsh', 'Gsh']:
	for key2 in ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'Ash', 'Csh' 'Dsh', 'Fsh', 'Gsh']:
		print requests.get('https://pianolock.kringlecastle.com/checkpass.php?i=%s%s&id=D' % (key, key2)).text
