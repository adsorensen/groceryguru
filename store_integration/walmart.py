from store import Store
from database import Database
import time
import requests
import json

class Walmart(Store):
    def __init__(self):
        super().__init__()

    def login(self, user, password):
        print("Logging in...")
        self.visit("https://walmart.com/account/login")
        self.browser.fill('email', user)
        self.browser.fill('password', password)
        self.browser.find_by_text('Sign In').click()
        time.sleep(0.15)

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
        print("Starting to add to cart...")
        cont = True
        while (cont):
            try:
                button = self.browser.find_by_css('button[data-automation-id="addToCartBtn"]')
                button.click()
                print("Clicked button...")
                cont = False
            except:
                try:
                    button = self.browser.find_by_css('button[data-automation-id="addToCartBtnOG"]')
                    button.click()
                    print("Clicked old button...")
                    cont = False
                except:
                    time.sleep(0.5)
                    print("Sleeping...")
                    

        
    #*****************************************************************
    # Main store function. Attempts to add all products in a user's
    # checklist to their Walmart Cart. First attempting to navigate to 
    # the saved url, then manually searching by name should that fail.
    #*****************************************************************
    def run_job(self, user_id):
        # Connect to DB, grab checklist products 
        self.login('', '')
        db = Database()
        ingredients = db.get_checklist_ingredients(user_id)
        print(ingredients)
        products = db.get_products(ingredients)
        print(products)
        
        # Search for and add all products to cart
        for product in products:
            print("Product starting...")
            print(product)
            print(product[0][3])
            self.visit(product[0][3])
            self.add_to_cart()   
            
        # Report whether success or not
        self.job_done(user_id, 1)
        print("Sent /done ")