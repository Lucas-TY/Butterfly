# Scrape the data and store in the database

This part is independent with rails part. We crawl the original data from website by ruby using machanize, and dump the raw data to json.

**The link be used to scrape the data:**
https://courses.osu.edu/psc/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.CLASS_SEARCH.GBL

**The link be used to get all CSE courses for Spring 2022 semester:**
https://www.classes.osu.edu/class-search/#/?q=cse&campus=col&p=1&term=1222&subject=cse&academic-career=ugrd

**Need to install mechanize:**
`gem install mechanize`

## Files:
**scrapeAndStoreMain.rb:** the script to crawl a course(by course id)

**usage:** `ruby scrapeAndStoreMain.rb <coureseid>`

**Example:** if you want to scrape CSE1110 course information, you can run: `ruby scrapeAndStoreMain.rb 1110`

**scrape.rb:** the script to scrape all the courses by invoke test.rb

**usage:** `ruby scrape.rb`

## Method

1. Get the website

2. Analyze and get a token

3. Post the course info

4. Parse the result