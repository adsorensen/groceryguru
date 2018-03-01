#!flask/bin/python
from flask import Flask
from flask import request
from flask import abort
from flask import jsonify
from controller import Controller
import requests
import random
import json

app = Flask(__name__)

controler = Controller()

@app.route('/', methods=['POST', 'GET'])
def create_job():
    print("Got Request")
    # if not request.json or not 'userId' in request.json:
    #     abort(400)

    # userId = request.json['userId']
    userId = request.args.get('userId')
    store = request.args.get('store')
    controler.receive_job(userId, store)

    return jsonify({'message': "Job received."}), 201

@app.route('/done', methods=['POST', 'GET'])
def job_done():
    # randombits = random.getrandbits(256)
    # key = "test"
    # hash = ""
    print("Job Finished")
    user_id = request.args.get('user')
    status = request.args.get('status')
    response = requests.post(
        url="http://localhost:8080/products/done",
        headers={
            "Content-Type": "application/json; charset=utf-8",
        },
        data=json.dumps({
            "userId": user_id,
            "status": status
        })
    )
    
    
    # print('Response HTTP Response Body: {content}'.format(
    #     content=response.content))
    print('Response HTTP Status Code: {status_code}'.format(
        status_code=response.status_code))
        
    return response.content


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8081)
