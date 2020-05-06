require 'asciiart'
require 'rmagick'
require 'catpix'
require 'tco'
require 'down'

class Interface < ActiveRecord::Base
# a = AsciiArt.new("https://upload.wikimedia.org/wikipedia/commons/d/d7/Meisje_met_de_parel.jpg")
#   #<AsciiArt:0x00000100878678 @file=#<File:/Users/sschor/Desktop/uncle_larry.jpg>>
#  puts a.to_ascii_art(color: true, width:100)


def self.greeting
    puts "Welcome to the NET Museum!"
    sleep(2)
    puts "Press -enter- to get started."
    gets.chomp 
end 


def self.menu
    puts ""
        puts "Search"
        puts "* Search by Artist Name ('search artists')"
        puts "* Search by Artwork Name ('search artworks')"
        puts "* Search by Department ('search departments')" 
        
        puts "Curate"
        puts "* Create a list of favorites ('create favorites')"
        puts "* View and Edit your list of favorites ('view list')"
        
        puts "Discover"
        puts "* What’s on view: see today’s highlighted piece ('random piece')"
        puts "* Overwhelmed? Let us get you started  (show 10 random artists) ('random artists')"
        
        puts"Extras"
        puts "* Learn more about the Net museum ('about')"
        puts "* Account Settings ('my account')"

end 



end 
#     Character.delete_all
# ActiveRecord::Base.logger = nil

# person = User.welcome
# person.start_story 
# person.item_problem 
# person.age_prob 
# person.item_problem_before_store
# #binding.pry
# puts "HELLO WORLD"