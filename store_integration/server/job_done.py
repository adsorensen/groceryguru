import requests
import random

def job_done(userId):
    # randombits = random.getrandbits(256)
    # key = "test"
    # hash = ""
    payload = {"userId": userId}
    print("Sending job complete: {}".format(str(userId)))
    response = requests.post('https://capstone-cs-4000-grocery-guru-rolsenrob.c9users.io', data=payload)