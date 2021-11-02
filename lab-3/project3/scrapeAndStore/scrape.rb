f=File.new("scrapeAndStore/classes","r")
f.each_line do |line|
    line=line.strip
    puts "invoke CSE #{line}"
    system "ruby scrapeAndStore/scrapeAndStoreMain.rb #{line}"
end