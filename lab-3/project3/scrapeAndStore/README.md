# PART 1
## Scrape the data and store in the database

This part is independent with rails part, We crawl the orginal data from website by ruby using machanize, and dump the raw data to json.

***The link be used to scrape the data:***
https://courses.osu.edu/psc/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.CLASS_SEARCH.GBL

***The link be used to find all the CSE courses:***
https://cse.osu.edu/courses  
Get all the course numbers listed on this page and store it in the file named "classes".

need to install mechanize: `gem install mechanize`

## files:
**scrapeAndStoreMain.rb:** the script to crawl a course(by course id)

**usage:** ruby test.rb <coureseid>



**scrape.rb** the script to crawl all the courses by invoke test.rb

the course ids is written in classes file

**usage:** ruby crawl.rb


## method

1.get the website

2.analyze and get a token

3.post a course info

4.parse the result