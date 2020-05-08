
####  to - do:
## update seed to include more data, without duplicates. currently at almost 1,000 artists and 2,000 artworks!! 
## but, only includes "european paintings" section of Met.
## increase accessibility functions 
## remove all instances of "puts"-ed out methods (bad!!)
## organize code by group (all search methods, creation methods, etc.)
## continue to build out under construction features
## remove any old notes that are no longer needed


## hi tashawn - global variables are used because of my ruby gems. i will have to work on that later :)


class User < ActiveRecord::Base
    has_many :user_artists
    has_many :user_artworks
    has_many :artworks, through: :user_artworks
    has_many :artists, through: :user_artists
    @@prompt = TTY::Prompt.new

    def menu_and_choices
        system("clear")
        puts User.menu 
        puts choices
    end



def self.menu
puts ""
puts ""
puts ""
pastel = Pastel.new
  puts "**************************************************************************"
  puts ""
    $menu_response =  @@prompt.select(pastel.bold("What would you like to do? - scroll through for all options")) do |menu|
            menu.choice 'Search by Artist Name', 'search artists'
            menu.choice 'Search by Artwork Name ', 'search artworks'
            menu.choice 'Search by Department', 'search departments'


            menu.choice 'Create a list of favorites', 'create favorites'
            menu.choice 'View and Edit your list of favorites ', 'view list'

 
        menu.choice 'What’s on view: see today’s highlighted piece', 'random piece'
        menu.choice 'Overwhelmed? Let us get you started (show 10 random artists)', 'random artists'
        

        menu.choice 'Learn more about the Net museum', 'about'
        menu.choice 'Account Settings', 'my account'


        menu.choice 'Exit', "exit"
     end

end 
    def self.username
        puts ""
        puts ""
        pastel = Pastel.new
        username = @@prompt.ask(pastel.bright_blue.bold("        Before you begin your tour, please tell us your name:")).strip
         
        if User.find_by(name: username)
            system("clear")
            puts ""
            puts ""
            puts ""

            puts pastel.bold("Welcome back, #{username}! What would you like to do?")
            sleep(1)
            puts User.menu 
            user = User.find_by(name:username)
        puts user.choices #or use TTY prompt 
        else 
        user = User.create(name:username) 
        puts ""
        system("clear")
        puts ""
        puts ""
        puts ""

        puts pastel.bold("Welcome #{username}!")
        sleep(1)
        puts "The Net museum is proud to offer you a virtual tour of thousands of pieces of art in our collection."
        sleep(1)
        puts "We have almost 1,000 artists whose work is available to view."
        sleep(1.5)
        puts "We've saved your information so you can start exploring."
        sleep(1.5)
        puts "Here’s what you can do with us today:"
        sleep(2)
        puts User.menu 
        user.choices 
        end 
    end
       
    def choices 
        pastel = Pastel.new
        case $menu_response 
        when  "random artists"
            random_artists
        when  "view list"
            self.view_list
        when "search artists"
            search_artists
        when "search artworks"
            search_artworks
        when "create favorites"
            create_list
        when "random piece"
            random_piece
        when "my account"
            my_account
        when "search departments"
            search_dept
        when "about"
            about
        when "exit" 
            sleep(1)
            puts ""
           puts pastel.bold("Thank you for visiting the NET museum. We hope to see you back soon!")
        exit

        end
    end               

    def search_dept
        system("clear")
        puts ""
        path = download_image("https://www.gshpinc.com/wp-content/uploads/2018/08/W20-7a.jpg")
        print print_pic(path)
        puts ""
        puts "This feature is under construction. Please check back soon!"
    end

    def any_key
        puts ""
        pastel = Pastel.new
        ans = @@prompt.ask(pastel.bold("Press any key to go back to menu"))
        if ans     
        menu_and_choices
        end
    end

    def search_artworks
        system("clear")
        sleep(1)
        pastel = Pastel.new
        puts ""
        puts ""
        puts ""
        @@prompt.warn(pastel.bright_blue("
            █████████             █████                                    █████          █████████                                   █████     
            ███░░░░░███           ░░███                                    ░░███          ███░░░░░███                                 ░░███      
           ░███    ░███ ████████  ███████  █████ ███ █████ ██████  ████████ ░███ █████   ░███    ░░░   ██████  ██████  ████████ ██████ ░███████  
           ░███████████░░███░░███░░░███░  ░░███ ░███░░███ ███░░███░░███░░███░███░░███    ░░█████████  ███░░███░░░░░███░░███░░█████░░███░███░░███ 
           ░███░░░░░███ ░███ ░░░   ░███    ░███ ░███ ░███░███ ░███ ░███ ░░░ ░██████░      ░░░░░░░░███░███████  ███████ ░███ ░░░███ ░░░ ░███ ░███ 
           ░███    ░███ ░███       ░███ ███░░███████████ ░███ ░███ ░███     ░███░░███     ███    ░███░███░░░  ███░░███ ░███   ░███  ███░███ ░███ 
           █████   ██████████      ░░█████  ░░████░████  ░░██████  █████    ████ █████   ░░█████████ ░░██████░░█████████████  ░░██████ ████ █████
          ░░░░░   ░░░░░░░░░░        ░░░░░    ░░░░ ░░░░    ░░░░░░  ░░░░░    ░░░░ ░░░░░     ░░░░░░░░░   ░░░░░░  ░░░░░░░░░░░░░    ░░░░░░ ░░░░ ░░░░░ 
                                                                                                                                                 
                                                                                                                                                 
                                                                                                                                                 "))
        
        puts ""
        puts ""    
        sleep(1)                                                                                                                                     
        puts "OK!"
        # puts "Please enter the name of the Artist you are searching for:"
        puts search_suggest_random_artwork
        answer = gets.chomp.strip.strip
        result = Artwork.find_by(title: answer)
        if !result 
            puts "Sorry, we couldn't find that piece. Try again?"
            sleep(1)
            puts "press any key to restart search."
            ans = gets.chomp
            search_artworks
        end
        puts "You've selected #{result.title}."
        search_artworks_helper(answer)

        ##### what do you want to do with this result???#####
    end

    def search_artworks_helper(name)
        result =  Artwork.where(title:name)
        sleep(1)
        puts "View this piece? (Y/n)"
        answer = gets.chomp.strip
        case answer
        when "Y"
        result.collect do |e|
        path = download_image(e.image)
        print print_pic(path)
        puts ""
        puts "              You are viewing #{e.title}. An exquisite work. What do you think?"
        puts ""
        sleep(1)
       any_key
        end
        when "n"
        puts "Ok. Let's try again!"
        system("clear")
        menu_and_choices
        end
    end
 
    def search_artists
        system("clear")
        sleep(1)
        puts ""
        puts ""
        puts ""
        pastel = Pastel.new
        @@prompt.warn(pastel.bright_blue("  
            
            █████████             █████    ███        █████        █████████                                   █████     
            ███░░░░░███           ░░███    ░░░        ░░███        ███░░░░░███                                 ░░███      
           ░███    ░███ ████████  ███████  ████  ████████████     ░███    ░░░   ██████  ██████  ████████ ██████ ░███████  
           ░███████████░░███░░███░░░███░  ░░███ ███░░░░░███░      ░░█████████  ███░░███░░░░░███░░███░░█████░░███░███░░███ 
           ░███░░░░░███ ░███ ░░░   ░███    ░███░░█████ ░███        ░░░░░░░░███░███████  ███████ ░███ ░░░███ ░░░ ░███ ░███ 
           ░███    ░███ ░███       ░███ ███░███ ░░░░███░███ ███    ███    ░███░███░░░  ███░░███ ░███   ░███  ███░███ ░███ 
           █████   ██████████      ░░█████ ███████████ ░░█████    ░░█████████ ░░██████░░█████████████  ░░██████ ████ █████
          ░░░░░   ░░░░░░░░░░        ░░░░░ ░░░░░░░░░░░   ░░░░░      ░░░░░░░░░   ░░░░░░  ░░░░░░░░░░░░░    ░░░░░░ ░░░░ ░░░░░ 
                                                                                                                          
                                                                                                                          
                                                                                                                          "))
        puts ""
        puts ""            
        sleep(1)                                                                                                     
        puts "OK!"
        # puts "Please enter the name of the Artist you are searching for:"
         search_suggest_random
        answer = gets.chomp.strip.strip
        result = Artist.find_by(artist_name: answer)
        if !result 
            puts pastel.bold("Sorry, we couldn't find that artist. Try again?")
            sleep(1)
            puts "press any key to restart search."
            ans = gets.chomp
            search_artists
        end
        puts "You've selected #{result.artist_name}."
        puts ""
        puts "What would you like to do?"
        puts "('view art', 'view artworks')"
        answer = gets.chomp.strip.strip
        case answer
        when "view art"
            system("clear")
                result.artworks.collect do |e|
                path = download_image(e.image)
                print print_pic(path)
                puts ""
                puts ""
                puts "                  You are viewing #{e.title}. Lovely, isn't it?"
                ## randomize the phrases ^ ###
                sleep(1)
                puts""
                any_key
            end
        when "view artworks"
            puts "Here are all of the artworks by this artist:"
            puts ""
            result.artworks.collect do |e|
                puts e.title
                puts ""
            end
           
                puts "view? (Y/N)"
                ans = gets.chomp.strip
               if ans == "Y"
                system("clear")
                    result.artworks.collect do |e|
                        path = download_image(e.image)
                        print print_pic(path)
                        comments = ["One of the highlights in our collection.", "What an interesting perspective - don't you think?", "What do you think the artist was feeling?", "Simply breathtaking."]
                    puts ""
                        puts "                       You are viewing #{e.title}. #{comments.sample}"
                        puts ""
                    end
                        sleep(1)
                        any_key
                end
               if ans == "N"
                        "OK!"
                        any_key
                     end
                ####when my data seed is correct it will show more than one!!####
           
            end

        ##### what do you want to do with this result???#####
        end

        def download_image(url)
            temp = Down.download(url)
            temp.path
        end
        def print_pic(path)
            options = {      
                :limit_x => 1.0,
                :limit_y => 1.0,
                :center_x => true,
                :center_y => true,
                :bg => "black",
                :bg_fill => false,
                :resolution => "high"
            }
            img = Catpix.print_image(path,options)
            # final_img = Magick::Image::read(img)
            # final_img.resize_to_fit(10,2)
        end
       
   
    def view_list
    system("clear")
    sleep(1)
    puts "Great!"
    sleep(1)
    puts "View Artists or Artworks?"
    response = gets.chomp.strip.strip
    case response
    when "Artists"
         view_my_artists
    when "Artworks"
         view_my_artworks
    end
    end

    def create_list
            if self.user_artworks.count > 0  || self.user_artists.count > 0
                puts "You already have a list! View it? (Y/n)"
                answer = gets.chomp.strip.strip
                case answer 
                when "Y"
                    puts view_list
                when "N"
                    puts "OK. Back to the menu!"
                    sleep(1)
                    system("clear")
                    menu_and_choices 
                end
                else
                puts "Add to Artists or Artworks? ('Artists' or 'Artworks')"
                answer = gets.chomp.strip.strip 
                    case answer
                    when "Artists"
                    add_artist
                    when "Artworks"
                    add_artwork
                    end
            end            

    end

  
    def view_my_artists
        system("clear")
        sleep(1)
    if self.user_artists.count == 0
            puts "Your list is empty! Want to add some artists? (Y/n)"
            response = gets.chomp.strip.strip
        if response == "Y" || response == "y"
                add_artist ##this isnt firing.##
        elsif response == "n" || response == "N"
                puts "some other time, then." 
              any_key
        end
    else 
            puts "Ok. Here's your current list of Artists:"
            puts ""         

            def my_current_artists 
                self.user_artists.map do |e|
                puts Artist.find(e.artist_id).artist_name
            end
        end

        my_current_artists
            # self.user_artists.each do |e|
            #     arr = []
            #     arr.push(e.artist_id)
            #     arr.collect do |a|
            #     finalAns = Artist.find(a).artist_name
            #       puts finalAns
            #    end             
            #    answer = gets.chomp.strip.strip
            # end

            puts "What would you like to do?"
            puts "('add artist', 'remove artists', 'select artist')"
            response = gets.chomp.strip.strip
            case response
            when "add artist"
                add_artist
            when "remove artists"
                remove_artist
            when "select artist"
                puts "Under Construction. Heading back to menu..."
                sleep(2)
                menu_and_choices
            end
    end
end          ###add option to go back to menu, or CRUD this list####  
    
def remove_artist
    puts ""
    puts "Which artist would you like to remove?"
    ans = gets.chomp.strip
    result = Artist.find_by(artist_name: ans)
    puts "You are removing #{result.artist_name}. Confirm? (Y/n)"
    yn = gets.chomp.strip

    if yn == "Y" || yn == "y"
        artist2 = result.artist_name
        ans = Artist.find_by(artist_name:artist2).id
        deletion = self.user_artists.find_by(artist_id:ans)
        deletion = deletion.delete.save

        puts "You have removed #{artist2}." 
        any_key
    end
    if yn == "N" || yn == "n"
       any_key
    end
end 

def remove_artwork
    puts ""
    puts "Which piece would you like to remove?"
    ans = gets.chomp.strip
    result = Artwork.find_by(title: ans)
    puts "You are removing #{result.title}. Confirm? (Y/n)"
    yn = gets.chomp.strip

    if yn == "Y" || yn == "y"
        artwork1 = result.title
        ans = Artwork.find_by(title:artwork1).id
        deletion = self.user_artworks.find_by(artwork_id:ans)
        deletion = deletion.delete.save
        puts "You have removed #{artwork1}." 
       any_key
    end
    if yn == "N" || yn == "n"
        any_key
    end
end 



    def view_my_artworks
        system("clear")
        sleep(1)
        if self.user_artworks.count == 0
            puts "Your list is empty! Want to add some artworks? (Y/n)"
            response = gets.chomp.strip
            case response
            when "Y"
                add_artwork
            when "n" || "N"
                puts "Some other time, then."
                puts "Returning to menu..."
                system("clear")
                menu_and_choices
             end
        end
        puts "OK. Here's your current list of Artworks:"
        puts ""

        self.user_artworks.map do |e|
            puts Artwork.find(e.artwork_id).title
        end
        puts ""
        puts "What would you like to do?"
        puts "('add artwork', 'remove artwork', 'select artwork')"
        response = gets.chomp.strip
        case response
        when "add artwork"
            add_artwork
        when "remove artwork"
            remove_artwork
        end    
     ###add option to go back to menu, or CRUD this list####
    end

  def random_piece
    system("clear")
    puts "Okay, selecting random artwork..."
    puts "..."
    sleep(1)
    piece = Artwork.all.collect do |e|
        e.image
    end.sample
    path = download_image(piece)
    print print_pic(path)

    puts ""
    comments = ["Wow - this one really makes you think...", "An impressive work - wouldn't you agree?", "Such an interesting piece...What do you think it means?", "Masterful!"]
    puts comments.sample
    sleep(1)
    puts ""
    any_key
  end

    def random_artists
        ansArr = [] 
        system("clear")
        sleep(2)
        puts "Here are 10 artists to get you started on your search!"
        sleep(1)
        puts ""
         Artist.all.each do |e|
            #using this conditional because right now my seed data has duplicates
            #ideal to remove and just show the list of artists normally.
            if !ansArr.include?(e.artist_name)
             ansArr.push(e.artist_name)
             ansArr.sort!
            end
        end     
    puts ansArr.sample(10)
    puts ""
    sleep(1)
  any_key
    end 

    def search_suggest_random
            ansArr = [] 
            sleep(1)
            puts "Here are some search suggestions.."
            puts ""
             Artist.all.each do |e|
                #using this conditional because right now my seed data has duplicates
                #ideal to remove and just show the list of artists normally.
                if !ansArr.include?(e.artist_name)
                 ansArr.push(e.artist_name)
                 ansArr.sort!
                else
                    next
                end
            end 
        puts ansArr.sample(4)
        puts ""
        puts "Please enter your search:"
        ##include option to go back to menu, or work with this list (edit, select an artist, etc.)
    end 


    def search_suggest_random_artwork
        ansArr = [] 
        sleep(1)
        puts "Here are some search suggestions.."
        puts ""
         Artwork.all.each do |e|
            #using this conditional because right now my seed data has duplicates
            #ideal to remove and just show the list of artists normally.
            if !ansArr.include?(e.title)
             ansArr.push(e.title)
             ansArr.sort!
            else
                next
            end
        end   
        puts ansArr.sample(4)
        puts ""
        puts "Please enter your search:"
    end

  

    def artwork_list
        self.user_artworks.each do |e|
            puts e.artwork_id.title
        end
    end

    def add_artist
        system("clear")
        puts "Enter the artist name to add to your list:"
        artist = gets.chomp.strip
        artist1 = Artist.find_by(artist_name: artist)
        if self.user_artists.count > 10
            puts "Sorry, you can't add any more artists (max. 10)"
            puts ""
            sleep(1)
           any_key
            if !artist1
                puts "Sorry - we can't find that artist."
                sleep(1)
                puts "Let's try again..." 
                system("clear")
                add_artist
            end
        else
            result = UserArtist.create(artist:artist1, user: self)
        puts "You've added #{artist1.artist_name} to your list."
        puts ""
        sleep(1)
        any_key
        end
        
        ###add artist_list method###
        # puts "Here's your updated list:"
        # puts ""
        # puts  artist_list
     
    end 


    def add_artwork
        system("clear")
        puts "Enter the Artwork title to add to your list:"
        artworkans = gets.chomp.strip
        artwork1 = Artwork.find_by(title:artworkans)
       
        if self.user_artworks.count > 10
            puts "Sorry, you can't add any more artworks."
        else
        if !artwork1
            puts "Sorry - we can't find that artwork."
            sleep(1)
            puts "Let's try again..." 
            system("clear")
            add_artwork
        end
        UserArtwork.create(artwork:artwork1, user: self)
        puts "You've added #{artwork1.title} to your list."
        sleep(1)
        puts ""      
        sleep(1)
        any_key
        ###add artist_list method###
        # puts "Here's your updated list:"
        # puts ""
        # puts  artist_list
      end 
    end

    def all_departments
        Artwork.all.collect do |e|
            puts e.all_department
        end
    end

    def my_account
        system("clear")
        puts "What would you like to do?"
        puts "('view bio', 'update bio', 'delete bio')"
        ans = gets.chomp.strip
        case ans
        when "view bio"
         my_bio
        when "update bio"
          update_bio
        when "delete bio"
            self.bio.delete
            puts "Your bio has been deleted."
            puts ""
            any_key
        end
     end 

        def my_bio
            ## check for bio and offer to update
            system("clear")
            puts ""
            puts "Here's your bio!"
            puts ""
            puts self.bio
            puts ""
            sleep(1)
            puts "Wow, you sure have a lot to say!"
            sleep(1)
           any_key
        end

def update_bio
    puts "Your current bio:"
    puts ""
    self.bio
    puts ""

    puts "Please enter your new bio."
    ans = gets.chomp.strip
    self.update(bio:ans)
    puts ""
    puts "Great! Bio updated."
    sleep(1)
    puts""
    any_key
end


def about
    pastel = Pastel.new

    system("clear")
    puts ""
    puts ""
    puts ""
    
    @@prompt.warn(pastel.blue("
        █████████   █████                          █████       ███████████ █████       ███             ███████████                          ███                     █████   
        ███░░░░░███ ░░███                          ░░███       ░█░░░███░░░█░░███       ░░░             ░░███░░░░░███                        ░░░                     ░░███    
       ░███    ░███  ░███████   ██████  █████ ████ ███████     ░   ░███  ░  ░███████   ████   █████     ░███    ░███ ████████   ██████      █████  ██████   ██████  ███████  
       ░███████████  ░███░░███ ███░░███░░███ ░███ ░░░███░          ░███     ░███░░███ ░░███  ███░░      ░██████████ ░░███░░███ ███░░███    ░░███  ███░░███ ███░░███░░░███░   
       ░███░░░░░███  ░███ ░███░███ ░███ ░███ ░███   ░███           ░███     ░███ ░███  ░███ ░░█████     ░███░░░░░░   ░███ ░░░ ░███ ░███     ░███ ░███████ ░███ ░░░   ░███    
       ░███    ░███  ░███ ░███░███ ░███ ░███ ░███   ░███ ███       ░███     ░███ ░███  ░███  ░░░░███    ░███         ░███     ░███ ░███     ░███ ░███░░░  ░███  ███  ░███ ███
       █████   █████ ████████ ░░██████  ░░████████  ░░█████        █████    ████ █████ █████ ██████     █████        █████    ░░██████      ░███ ░░██████ ░░██████   ░░█████ 
      ░░░░░   ░░░░░ ░░░░░░░░   ░░░░░░    ░░░░░░░░    ░░░░░        ░░░░░    ░░░░ ░░░░░ ░░░░░ ░░░░░░     ░░░░░        ░░░░░      ░░░░░░       ░███  ░░░░░░   ░░░░░░     ░░░░░  
                                                                                                                                        ███ ░███                             
                                                                                                                                       ░░██████                              
                                                                                                                                        ░░░░░░                               "

    ))
    puts ""
    puts ""
    puts "      The Net Museum is proud to present a virtual representation of thousands of pieces of art from around the world. Available to view from the comfort of your own home!  
    
    The Net Museum Application was created by me, #{pastel.bold("Rosie Wilt")}. Director of the Net Museum and student at Flatiron School. 

    This project is powered by the Met Museum’s public API. All works on view are property of the Museum and presented here for your enjoyment.   
    Images are powered by Catpix/RMagick gems. Because of this - all images will present differently in your Terminal.
    Experience the art you know and love in a new way. Discover new works in a format possibly unfamiliar to you. Have fun! 
    "
    puts ""
    sleep(1.5)
   any_key
end

    
end
#add_artist example commands:
#rosie = User.first
# rosie.add_artist("Anthony van Dyck")
# rosie.user_artists
# rosie.user_artists.all