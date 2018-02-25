from splinter import Browser

class Store(object):
    def __init__(self):
        self.browser = Browser("chrome")
        pass

    def search(self, query):
        pass

    def get_cheapest(self, id):
        pass

    def go_to_product(self, id):
        pass

    def login(self, user, password):
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