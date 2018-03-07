#!/python-mysqldb_1.2.3-2ubuntu1_amd64.deb
import pymysql.cursors

class Database(object):
    def __init__(self):
        self.db = pymysql.connect(host="localhost",
                                  user="root", 
                                  passwd="",
                                  db="groceryguru")
        
    def get_checklist_ingredients(self, user_id):
        sql = "SELECT * FROM checkout_lists WHERE user_id="+str(user_id)+";"
        
        cursor = self.db.cursor()
        
        try:
           # Execute the SQL command
           cursor.execute(sql)
           # Fetch all the rows, return a list
           checklist = cursor.fetchall()
        except:
           print ("Error: Could not fetch checklist")
           
        ingredients = []   
        for ingredient in checklist:
            sql = "SELECT * FROM ingredients WHERE id="+str(ingredient[2])+";"
            
            try:
               cursor.execute(sql)
               ingred = cursor.fetchall()
               ingredients.append(ingred)
            except:
                print ("Error: Could not fetch ingredient")
                
        return ingredients
           
           
    
    def get_products(self, ingredients):
        products = []
        for ingredient in ingredients:
            sql = "SELECT * FROM products WHERE id="+str(ingredient[0][4])+";"
            cursor = self.db.cursor()
            
            try:
               cursor.execute(sql)
               prod = cursor.fetchall()
               products.append(prod)
            except:
                print ("Error: Could not fetch product")
                
        return products
        
    def close_connection(self):
        # Disconnect from server
        self.db.close()
        
# db = Database()
# check = db.get_checklist_ingredients(1)
# print(check)
# db.close_connection()