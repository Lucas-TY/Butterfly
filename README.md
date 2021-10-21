# <font color=red>Deadline is October 31 at 11:59pm</font>
---

# (Review) How to create a branch
## First time
```
git clone git@github.com:cse-3901-sharkey/Butterfly.git
cd Butterfly
git checkout -b  replaceItWithYourBranchName
git push --set-upstream origin replaceItWithYourBranchName
```
## Next time
```
git pull origin main
git add -A
git commit -m "replaceItWithYourCommitMessage"
git push 
```
---

# What we've done
## Web Scraping
+ We've used Ruby to scrape all of course information in the professor's appointed websites, and store all data into the data folder. 
+ Used websites information are showed below:

***The link be used to scrape the data:***
https://courses.osu.edu/psc/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.CLASS_SEARCH.GBL

***The link be used to find all the CSE courses:***
https://cse.osu.edu/courses  
Get all the course numbers listed on this page and store it in the file named "classes".

## Database and basic architecture
+ We've transformed and stored course information into the databased created in SQLite and also perform rails to create one basic model and view.

# The remaining parts:
***1) Updating the existing web model and view to display the courses and sections entered in the database as well as much more functions.***

***2) Adding a login/logout functionality along with its corresponding login page.***

***3) Creating a console view of the application so that it can be run in the console.***
