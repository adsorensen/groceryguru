To get started with Grocery Guru please follow the below instructions:

Set up mysql in c9:
https://community.c9.io/t/setting-up-mysql/1718
https://www.digitalocean.com/community/tutorials/how-to-use-mysql-with-your-ruby-on-rails-application-on-ubuntu-14-04

Set up store_integration dependencies:
https://christopher.su/2015/selenium-chromedriver-ubuntu/

Set up python:
http://docs.python-guide.org/en/latest/starting/install3/linux/

1. Set up git repo using code base.
2. Pull down into a c9.io workspace.
3. Run 'rake db:migrate'.
4. Run 'bundle install'.
5. Open store_integration folder and run command 
   'python3 app.py' on a separate server machine. 
   Copy the code from store_integration to this folder. 
   (Must be separate and publicly accessible by GG)
6. Run 'mysql-ctl cli' to start MySQL server. 
7. In mysql prompt run the following commands in the root directory: 'source ingredientsQuery', 'source recipeQuery', 'source instructionsQuery'
8. Next we need to run the product population script to populate our product database. Navigate to the store_integration folder and run 'python3 productPopulator.py'. This script will take quite a long time to complete. This should be done on the same machine as the c9 repo.
9. Next run 'mysql-ctl cli' and run the following commands: 'source productsQuery', 'source ingredientsProductQuery'
10. In the following file update the URL currently set as: "https://grocery-guru-nguyenmichelle.c9users.io:8081/?userId=5&store=walmart" to point to your newly created Python server.  
11. Now you can hit Run Project to run your ruby application.
 
 
 
 
 
 
     ,-----.,--.                  ,--. ,---.   ,--.,------.  ,------.
    '  .--./|  | ,---. ,--.,--. ,-|  || o   \  |  ||  .-.  \ |  .---'
    |  |    |  || .-. ||  ||  |' .-. |`..'  |  |  ||  |  \  :|  `--, 
    '  '--'\|  |' '-' ''  ''  '\ `-' | .'  /   |  ||  '--'  /|  `---.
     `-----'`--' `---'  `----'  `---'  `--'    `--'`-------' `------'
    ----------------------------------------------------------------- 


Welcome to your Rails project on Cloud9 IDE!

To get started, just do the following:

1. Run the project with the "Run Project" button in the menu bar on top of the IDE.
2. Preview your new app by clicking on the URL that appears in the Run panel below (https://HOSTNAME/).

Happy coding!
The Cloud9 IDE team


## Support & Documentation

Visit http://docs.c9.io for support, or to learn more about using Cloud9 IDE. 
To watch some training videos, visit http://www.youtube.com/user/c9ide

----------------- General Notes ----------------------

Database:
    Root User: root
    Database Name: c9 for test, groceryguru for dev
     
Test User:
    User Name: test
    email: test@test.com
    password: password
    

Start MySQL Server command:    -> Run this before running the application if the workspace has been idle for a while
    mysql-ctl cli