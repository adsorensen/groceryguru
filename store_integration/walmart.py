from store import Store

class Walmart(Store):
    def __init__(self):
        super().__init__()

    def login(self, user, password):
        self.browser.visit("https://walmart.com/account/login")
        self.browser.fill('email', user)
        self.browser.fill('password', password)
        self.browser.find_by_text('Sign In').click()

    def get_price(self, url):
        self.browser.visit(url)