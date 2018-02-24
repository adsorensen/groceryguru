#!flask/bin/python
from flask import Flask
from flask import request
from flask import abort
from flask import jsonify

app = Flask(__name__)

jobs = {}

@app.route('/', methods=['POST', 'GET'])
def create_job():
    print("Got Request")
    if not request.json or not 'userId' in request.json:
        abort(400)

    userId = request.json['userId']
    done = False

    jobs[userId] = done
    print(jobs)

    return jsonify({'message': "Job received."}), 201

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8081)
