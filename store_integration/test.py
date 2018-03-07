from store import Store
from walmart import Walmart
from database import Database

def test_search_and_cheapest():
    wal = Walmart()
    
    wal.login('', '')
    print("Logged in...")
    wal.search("bread")
    
    print("Results Dict....")
    for name in wal.results.keys():
        print(name + ": " + str(wal.results[name]))
    
    cheap = wal.get_cheapest()
    print('\nCheapest: ' + cheap + " at: " + str(wal.results[cheap]))
    
# test_search_and_cheapest()

wal = Walmart()
wal.login('', '')
wal.run_job(1)