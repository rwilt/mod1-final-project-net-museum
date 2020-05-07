
class User < ActiveRecord::Base
    has_many :user_artists
    has_many :user_artworks
    has_many :artworks, through: :user_artworks
    has_many :artists, through: :user_artists
    @@prompt = TTY::Prompt.new

    def menu_and_choices
        system("clear")
        puts Interface.menu 
        puts choices
    end

    def self.username
        puts "Before you begin your tour, please tell us your name:"
        username = gets.chomp.strip
         
        if User.find_by(name: username)
            puts ""
            puts "Welcome back, #{username}! What would you like to do?"
            sleep(1)
            puts Interface.menu 
            user = User.find_by(name:username)
        puts user.choices #or use TTY prompt 
        else 
        user = User.create(name:username) 
        puts ""
        puts "Welcome #{username}!"
        sleep(1)
        puts "The Net museum is proud to offer you a virtual tour of thousands of pieces of art in our collection."
        sleep(1.5)
        puts "We've saved your information so you can start exploring."
        sleep(1.5)
        puts "Here’s what you can do with us today:"
        sleep(2)
        menu_and_choices #or use TTY prompt 
        end 
    end
       
    def choices 
        answer = gets.chomp.strip
        case answer 
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
        end
    end               

    def search_artworks
        system("clear")
        sleep(1)
        puts ""
        puts "OK!"
        sleep(1)
        # puts "Please enter the name of the Artist you are searching for:"
        puts search_suggest_random_artwork
        answer = gets.chomp.strip
        result = Artwork.find_by(title: answer)
        puts "You've selected #{result.title}."
        search_artworks_helper(answer)

        ##### what do you want to do with this result???#####
    end

    def search_artworks_helper(name)
        result =  Artwork.where(title:name)
        sleep(1)
        puts "View this piece? (Y/n)"
        answer = gets.chomp
        case answer
        when "Y"
        result.collect do |e|
        path = download_image(e.image)
        print print_pic(path)
        puts ""
        puts "You are viewing #{e.title}. An exquisite work. What do you think?"
        puts ""
        sleep(1)
        puts "press any key to go back to menu"
        ans = gets.chomp
        menu_and_choices
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
        puts "OK!"
        sleep(1)
        # puts "Please enter the name of the Artist you are searching for:"
        puts search_suggest_random
        answer = gets.chomp.strip
        result = Artist.find_by(artist_name: answer)
        puts "You've selected #{result.artist_name}."
        puts ""
        puts "What would you like to do?"
        puts "('view art', 'view artworks')"
        answer = gets.chomp.strip
        case answer
        when "view art"
            system("clear")
                result.artworks.collect do |e|
                path = download_image(e.image)
                print print_pic(path)
                puts ""
                puts ""
                puts "You are viewing #{e.title}. Lovely, isn't it?"
                ## randomize the phrases ^ ###
            end
        when "view artworks"
            puts "Here are all of the artworks by this artist:"
            puts ""
            result.artworks.collect do |e|
                puts e.title
                puts ""
            end
                puts "view? (Y/N)"
                ans = gets.chomp
               if ans == "Y"
                    result.artworks.collect do |e|
                        path = download_image(e.image)
                        print print_pic(path)
                    
                        puts "You are viewing #{e.title}. A wonderful piece, dont you agree?"
                        puts ""
                    end
                        sleep(1)
                        puts "press any key to go back to menu"
                        ans = gets.chomp
                        menu_and_choices
               if ans == "N"
                        puts "Ok. Back to menu!"
                        system("clear")
                        menu_and_choices
                     end
                ####when my data seed is correct it will show more than one!!####
             end
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
    response = gets.chomp.strip
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
                answer = gets.chomp.strip
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
                puts "Add to Artists or Artworks?"
                answer = gets.chomp.strip 
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
            response = gets.chomp.strip
        if response == "Y" || response == "y"
                add_artist ##this isnt firing.##
        elsif response == "n" || response == "N"
                puts "some other time, then." 
                ####back to menu?######
                ### HELP. either the code quits the program when i choose yes, or throws an error####
        end
    else 
            puts "Ok. Here's your current list of Artists:"
            puts ""
            
            self.user_artists.each do |e|
                arr = []
                arr.push(e.artist_id)
                arr.collect do |a|
                  finalAns = Artist.find(a).artist_name
                  print finalAns
               end
             
            #    answer = gets.chomp.strip
            end
            puts "What would you like to do?"
            puts "('add artist', 'remove artists', 'select artist')"
            response = gets.chomp.strip
            case response
            when "add artist"
                add_artist
            end
            
        end
            ###add option to go back to menu, or CRUD this list####  
    end

    def view_my_artworks
        system("clear")
        sleep(1)
        if self.user_artworks.count == 0
            puts "Your list is empty! Want to add some artworks? (Y/n)"
            response = gets.chomp
            case response
            when "Y"
                puts add_artwork
            when "n" || "N"
                puts "Some other time, then."
                puts "Returning to menu..."
                system("clear")
                menu_and_choices
             end
        end
        puts "OK. Here's your current list of Artworks:"
        puts ""
        self.user_artworks.each do |e|
            puts e.artwork_id.title
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
    end.sample.first

    path = download_image(piece)
    print print_pic(path)
  end

    def random_artists
        ansArr = [] 
        system("clear")
        sleep(2)
        puts "Here are 10 Artists to get you started!"
        sleep(1)
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
    puts ansArr.sample(10)
    ##include option to go back to menu, or work with this list (edit, select an artist, etc.)
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
        artist = gets.chomp
        artist1 = Artist.find_by(artist_name: artist)
        result = UserArtist.create(artist:artist1, user: self)
        puts "Youve added #{artist1} to your list."
        sleep(1)
        ###add artist_list method###
        # puts "Here's your updated list:"
        # puts ""
        # puts  artist_list
        if self.user_artists.count > 10
            puts "Sorry, you can't add any more artists."
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
        ans = gets.chomp
        case ans
        when "view bio"
         my_bio
        when "update bio"
            puts "Your current bio:"
            puts ""
            self.bio
            puts ""

            puts "Please enter your new bio."
            ans = gets.chomp
            new_bio = self.update(bio:ans)
            puts ""
            puts "Great! Here's your new bio:"
            new_bio
        end

    end 
        def my_bio
            system("clear")
            puts ""
            puts "Here's your bio!"
            puts ""
            puts self.bio
            puts ""
            sleep(2)
            puts "return to menu? (Y/n)"
            ans = gets.chomp
            case ans 
            when "Y"
                system("clear)")
                menu_and_choices
            when "n"
                puts "Sure - make yourself comfortable. Press enter to return."
                ans = gets.chomp
            when ans 
                menu_and_choices
            end
             #see your own bio. add methods to update/delete bio.
         end
#end of class
end



    

#add_artist example commands:
#rosie = User.first
# rosie.add_artist("Anthony van Dyck")
# rosie.user_artists
# rosie.user_artists.all