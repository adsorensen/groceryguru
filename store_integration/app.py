#!flask/bin/python
from flask import Flask
from flask import request
from flask import abort
from flask import jsonify
from flask import redirect
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
    
    return redirect("https://grocery.walmart.com/")
    
# def job_done(user_id, status):
#     print("Job Finished")
#     response = requests.post(
#         url="http://localhost:8080/products/done",
#         headers={
#             "Content-Type": "application/json; charset=utf-8",
#         },
#         data=json.dumps({
#             "userId": user_id,
#             "status": status
#         })
#     )
    
#     print('Response HTTP Status Code: {status_code}'.format(
#         status_code=response.status_code))
        
#     return response.content


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8081, threaded=True)
