import socket
import ssl

from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/')
def hello():
    ip = request.remote_addr
    return jsonify({'message': 'Hello, client!', 'ip': ip})

if __name__ == '__main__':
    # app.run(host='0.0.0.0', port=443, ssl_context='adhoc')
    # app.run(host='0.0.0.0', port=443, ssl_context=('cert.pem', 'key.pem'))
    app.run()
