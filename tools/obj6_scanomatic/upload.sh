#!/bin/bash

BADGE=$(mktemp -t badge)
    
CMD="$1"
    
qrencode -t ansi "$CMD" -o $BADGE -t PNG

mv $BADGE $BADGE.png

curl -s 'https://scanomatic.kringlecastle.com/upload' -H 'Pragma: no-cache' -H 'Origin: https://scanomatic.kringlecastle.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9,ro;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36' -H 'Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryE5NDB3VfvlaU4Z8s' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Cache-Control: no-cache' -H 'X-Requested-With: XMLHttpRequest' -H 'Cookie: resource_id=false' -H 'Connection: keep-alive' -H 'Referer: https://scanomatic.kringlecastle.com/index.html' -F "barcode=@$BADGE.png" 

rm $BADGE.png
