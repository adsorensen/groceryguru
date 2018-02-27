from store import Store
import time

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

        # Keep trying to find the price until the page is loaded. Try both old and new versions of the product page.
        cont = True
        while (cont):
            try:
                dollarSpan = self.browser.find_by_css('span[data-automation-id="wholeUnitsOG"]')
                centsSup = self.browser.find_by_css('sup[data-automation-id="partialUnitsOG"]')
                priceS = dollarSpan.text + "." + centsSup.text
                price = float(priceS)
                cont = False
            except:
                try:
                    dollarSpan = self.browser.find_by_css('span[data-automation-id="wholeUnits"]')
                    centsSup = self.browser.find_by_css('sup[data-automation-id="partialUnits"]')
                    priceS = dollarSpan.text + "." + centsSup.text
                    price = float(priceS)
                    cont = False
                except:
                    time.sleep(1)

        print(price)

        return price
        
    def search(self, query):
        self.browser.visit('https://www.walmart.com/search/?query=' + query)
        
        # Loop over results and store in map
        
        
    def get_cheapest(self):
        price = min(results.values())
        return list(results.keys())[list(results.values()).index(price)]
        
    def add_to_cart(self, url):