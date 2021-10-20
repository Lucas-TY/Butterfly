f=File.new("classes","r")
f.each_line do |line|
    line=line.strip
    puts "invoke CSE #{line}"
    system "ruby scrapeAndStoreMain.rb #{line}"
end