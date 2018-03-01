from splinter import Browser

class Store(object):
    def __init__(self):
        self.browser = Browser("chrome", headless=True)
        self.results = {}
        pass

    def visit(self, url):
        self.browser.visit(url) 

    def search(self, query):
        raise NotImplementedError("Should have implemented this")

    def get_cheapest(self, id):
        raise NotImplementedError("Should have implemented this")

    def go_to_product(self):
        pass

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
    
    #*****************************************************************
    # Main store function. Attempts to add all products in a user's
    # checklist to their Walmart Cart. First attempting to navigate to 
    # the saved url, then manually searching by name should that fail.
    #*****************************************************************
    def run_job(self, user_id):
        raise NotImplementedError("Should have implemented this")