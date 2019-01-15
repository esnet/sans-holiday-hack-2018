from subprocess import Popen, PIPE
import urllib

from flask import Flask, request, jsonify
app = Flask(__name__)

@app.route('/')
def proxy():
    uid = urllib.unquote(request.args.get('uid', ''))
    p = Popen(['bash', './upload.sh', uid], stdin=PIPE, stdout=PIPE, stderr=PIPE)
    output, err = p.communicate()
    return jsonify(output)
