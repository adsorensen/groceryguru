from store import Store
from walmart import Walmart

class Controller(object):
    def __init__(self):
        self.jobs = {}

    def receive_job(self, user_id, store):
        if store == "walmart":
            job = Walmart()
        
        # Add job to tracked list and run
        self.jobs[user_id] = job
        job.run_job(user_id) 
        
