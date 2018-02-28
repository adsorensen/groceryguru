from splinter import Browser

class Store(object):
    def __init__(self):
        self.browser = Browser("chrome", headless=True)
        self.results = {}
        pass

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

    def get_price(self, url):
        raise NotImplementedError("Should have implemented this")

    def get_brand(self):
        pass