from splinter import Browser
from time import sleep
from exceptions import PageNotLoadedException

class Store(object):
    def __init__(self):
        self.browser = Browser("chrome", headless=True)
        self.results = {}
        pass

    def visit(self, url, wait=True):
        self.browser.visit(url)
        if wait:
            self.wait_pageload()

    def search(self, query):
        raise NotImplementedError("Should have implemented this")

    def get_cheapest(self, id):
        raise NotImplementedError("Should have implemented this")

    def login(self, user, password):
        raise NotImplementedError("Should have implemented this")

    def add_to_cart(self):
        raise NotImplementedError("Should have implemented this")
    
    def add_to_cart_price(self):
        pass

    def add_to_cart_brand(self):
        pass

    def add_to_cart_size(self):
        pass

    def empty_cart(self):
        pass

    def get_price(self):
        raise NotImplementedError("Should have implemented this")

    def get_brand(self):
        pass

    def get_name(self):
        raise NotImplementedError("Should have implemented this")

    def execute_javascript(self, script):
        return self.browser.evaluate_script(script)

    def wait_pageload(self, timeout=30):
        wait_interval = 0.05
        elapsed = 0

        while self.execute_javascript('document.readyState') != 'complete':
            sleep(wait_interval)
            elapsed += wait_interval

            if elapsed > timeout:
                raise PageNotLoadedException

    #*****************************************************************
    # Main store function. Attempts to add all products in a user's
    # checklist to their Walmart Cart. First attempting to navigate to 
    # the saved url, then manually searching by name should that fail.
    #*****************************************************************
    def run_job(self, user_id):
        raise NotImplementedError("Should have implemented this")