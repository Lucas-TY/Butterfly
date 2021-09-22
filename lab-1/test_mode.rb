require "./CardModule/card-set-addMode.rb"

a=CardModule::CardSet.new

puts "normal_shuffle"
a.print_deck!


puts "rookie_shuffle1"
a.rookie_shuffle1!
a.print_deck!

puts "rookie_shuffle2"
a.rookie_shuffle2!
a.print_deck!
