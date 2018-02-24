import requests
import random
import json

def job_done(userId):
    # randombits = random.getrandbits(256)
    # key = "test"
    # hash = ""
    response = requests.get(
        url="http://localhost:8080/products/done",
        headers={
            "Content-Type": "application/json; charset=utf-8",
        },
        data=json.dumps({
            "userId": "12"
        })
    )
    
    
    print('Response HTTP Response Body: {content}'.format(
        content=response.content))
    print('Response HTTP Status Code: {status_code}'.format(
        status_code=response.status_code))
    
job_done(1)