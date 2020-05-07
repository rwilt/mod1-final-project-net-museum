
# require 'rmagick'
require 'catpix'
require 'tco'
require 'down'
require 'tty-prompt'
class Interface < ActiveRecord::Base

@@prompt = TTY::Prompt.new


def self.greeting
    pastel = Pastel.new
   puts ""
   puts ""
   puts ""
    @@prompt.warn(pastel.blue("
        █████   ███   █████          ████                                                 █████                                 
        ░░███   ░███  ░░███          ░░███                                                ░░███                                  
         ░███   ░███   ░███   ██████  ░███   ██████   ██████  █████████████    ██████     ███████    ██████                      
         ░███   ░███   ░███  ███░░███ ░███  ███░░███ ███░░███░░███░░███░░███  ███░░███   ░░░███░    ███░░███                     
         ░░███  █████  ███  ░███████  ░███ ░███ ░░░ ░███ ░███ ░███ ░███ ░███ ░███████      ░███    ░███ ░███                     
          ░░░█████░█████░   ░███░░░   ░███ ░███  ███░███ ░███ ░███ ░███ ░███ ░███░░░       ░███ ███░███ ░███                     
            ░░███ ░░███     ░░██████  █████░░██████ ░░██████  █████░███ █████░░██████      ░░█████ ░░██████     ██    ██    ██   
             ░░░   ░░░       ░░░░░░  ░░░░░  ░░░░░░   ░░░░░░  ░░░░░ ░░░ ░░░░░  ░░░░░░        ░░░░░   ░░░░░░     ░░    ░░    ░░    
                                                                                                                                 
                                                                                                                                 
                                                                                                                                  "))
    sleep(1)
    
    @@prompt.warn(pastel.bright_blue("

        █████    █████                  ██████   █████           █████       ██████   ██████                                                        ███
        ░░███    ░░███                  ░░██████ ░░███           ░░███       ░░██████ ██████                                                        ░███
        ███████   ░███████    ██████     ░███░███ ░███   ██████  ███████      ░███░█████░███  █████ ████  █████   ██████  █████ ████ █████████████  ░███
       ░░░███░    ░███░░███  ███░░███    ░███░░███░███  ███░░███░░░███░       ░███░░███ ░███ ░░███ ░███  ███░░   ███░░███░░███ ░███ ░░███░░███░░███ ░███
         ░███     ░███ ░███ ░███████     ░███ ░░██████ ░███████   ░███        ░███ ░░░  ░███  ░███ ░███ ░░█████ ░███████  ░███ ░███  ░███ ░███ ░███ ░███
         ░███ ███ ░███ ░███ ░███░░░      ░███  ░░█████ ░███░░░    ░███ ███    ░███      ░███  ░███ ░███  ░░░░███░███░░░   ░███ ░███  ░███ ░███ ░███ ░░░ 
         ░░█████  ████ █████░░██████     █████  ░░█████░░██████   ░░█████     █████     █████ ░░████████ ██████ ░░██████  ░░████████ █████░███ █████ ███
          ░░░░░  ░░░░ ░░░░░  ░░░░░░     ░░░░░    ░░░░░  ░░░░░░     ░░░░░     ░░░░░     ░░░░░   ░░░░░░░░ ░░░░░░   ░░░░░░    ░░░░░░░░ ░░░░░ ░░░ ░░░░░ ░░░ 
                                                                                                                                                        
                                                                                                                                                        
                                                                                                                                                        ") )                                                                       
                                                                                                                          
                                                                                                                          
    sleep(1)
    puts ""
    puts ""  
    @@prompt.warn(pastel.bright_blue.italic("        Please ensure you are in full-screen mode for best experience."))
    puts ""
    sleep(1)
    @@prompt.warn(pastel.bright_blue.italic("        Press -enter- to get started."))
    gets.chomp 
    
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