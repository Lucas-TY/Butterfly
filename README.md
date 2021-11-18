# <font color=red>Beta deadline is December 4 at 11:59pm (Midnight)</font>
# <font color=red>Full release deadline is December 10 at 12:00pm (Noon)</font>
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
# From Project 3
## What we've done
### Web Scraping
+ We've used Ruby to scrape all of course information in the professor's appointed websites, and store all data into the data folder. 
+ Used websites information are showed below:

***The link be used to scrape the data:***
https://courses.osu.edu/psc/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.CLASS_SEARCH.GBL

***The link be used to find all the CSE courses:***
https://cse.osu.edu/courses  
Get all the course numbers listed on this page and store it in the file named "classes".

---
# Project 4
## Critical Features (See assignment page for details) 
<h4>Implement By December 1:</h4>

***1) Application Submission. Assigned: TBD***

***2) Administrator Interface. Assigned: TBD***

***3) Available Course/Sections. Assigned: TBD***

***4) External Data Sources. Assigned: TBD***

***5) Recommendation Submission. Assigned: TBD***

## Extensions (See assignment page for details)
<h4>Implement after critical features are complete and tested</h4>

***1) Applicant Preferences. Assigned: TBD***

***2) Evaluation. Assigned: TBD***

***3) Optimal Mathcing. Assigned: TBD***
