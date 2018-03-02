from store import Store
import time
import requests
import json

class Walmart(Store):
    def __init__(self):
        super().__init__()

    def login(self, user, password):
        self.visit("https://walmart.com/account/login")
        self.browser.fill('email', user)
        self.browser.fill('password', password)
        self.browser.find_by_text('Sign In').click()

    def get_price(self):
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

    def get_name(self):
        cont = True
        while (cont):
            try:
                nameDiv = self.browser.find_by_css('div[data-automation-id="name"]')
                name = nameDiv.text
                cont = False
            except:
                try:
                    nameDiv = self.browser.find_by_css('span[data-automation-id="nameOG"]')
                    name = nameDiv.text
                    cont = False
                except:
                    time.sleep(1)

        print(name)

        return name
        
    def search(self, query):
        self.visit('https://www.walmart.com/search/?query=' + query)
        
        # Loop over results and store in map
        items = self.browser.find_by_css('.search-result-gridview-item-wrapper')

        for item in items:
            try:  # Grab Name and Price
                name = item.find_by_css('.product-title-link')['aria-label']
                price = item.find_by_css('.Price-group')['aria-label']
                price = float(price.replace("$", ""))
                self.results[name] = price
            except:  # Skip if can't buy item online
                continue
            
        
    def get_cheapest(self):
        price = min(self.results.values())
        return list(self.results.keys())[list(self.results.values()).index(price)]
        
    def add_to_cart(self):
        cartDiv = self.browser.find_by_css('.prod-ProductCTAAddToCart')
        button = cartDiv.first.find_by_tag("button").first
        button.click()

        
    #*****************************************************************
    # Main store function. Attempts to add all products in a user's
    # checklist to their Walmart Cart. First attempting to navigate to 
    # the saved url, then manually searching by name should that fail.
    #*****************************************************************
    def run_job(self, user_id):
        # Connect to DB, grab checklist, search for and add all products to cart
        
        # Report whether success or not
        self.job_done(user_id, 1)
        print("Sent /done ")