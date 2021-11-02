require 'mechanize'
require 'json'
require 'set'

$agent = Mechanize.new
term=1222
next_page_link="https://content.osu.edu/v2/classes/search?q=cse&campus=col&p=1&term=#{term}&subject=cse&academic-career=ugrd"
puts "get Spring 2022 semester, scraping course list..."
course_ids=[]
while true
    page=$agent.get(next_page_link)
    data=JSON.parse(page.body)["data"]
    courses=data["courses"]
    courses.each do |course|
        course_ids.append(course["course"]["catalogNumber"])
    end
    total_pages=data["totalPages"]
    page_now=data["page"]
    puts "parsing page #{page_now}"
    if page_now<total_pages
        next_page_link="https://content.osu.edu/v2/classes/search"+data["nextPageLink"]
    else
        break
    end
end
course_ids.sort!
course_ids=Set.new(course_ids).to_a

puts "course parsed, totally #{course_ids.length()} courses"
puts course_ids
puts "start invoking scraper"

course_ids.each do |line|
    line=line.strip
    puts "invoke #{line}"
    system "ruby scrapeAndStoreMain.rb #{line} #{term}"
end