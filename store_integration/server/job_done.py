import requests
import random

def job_done(userId):
    # randombits = random.getrandbits(256)
    # key = "test"
    # hash = ""
    payload = {"userId": userId}
    print("Sending job complete: {}".format(str(userId)))
    response = requests.post('http://localhost:5000/', data=payload)