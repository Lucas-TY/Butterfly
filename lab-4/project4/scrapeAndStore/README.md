# Scrape the data and store in the database

This part is independent with rails part. We crawl the original data from website by ruby using machanize, and dump the raw data to json.

**The link be used to get all CSE courses:**
https://www.classes.osu.edu/class-search/#/?q=cse&campus=col&p=1&term=1222&subject=cse&academic-career=ugrd

**Need to install mechanize:**
`gem install mechanize`

## Files:

**Example:** if you want to scrape CSE1110 course information, you can run: `ruby scrapeAndStoreMain.rb 1110`

**scrape.rb:** the script to scrape all the courses

**usage:** `ruby scrape.rb <term_id (optional)>`

## Method

1. Get the website

2. Analyze and get a token

3. Post the course info

4. Parse the result
