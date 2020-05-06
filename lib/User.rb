class User < ActiveRecord::Base
    has_many :user_artists
    has_many :user_artworks
    has_many :artworks, through: :user_artworks
    has_many :artists, through: :user_artists

    def all_artists
        ansArr = [] 
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
    ansArr
    end 

    def my_bio
       puts self.bio
        #see your own bio. add methods to update/delete bio.
    end

    def add_artist(artist)
        artist1 = Artist.find_by(artist_name: artist)
        UserArtist.create(artist:artist1, user: self)
        if self.user_artists.count > 10
            puts "Sorry, you can't add any more artists."
        end
    end 
end

#add_artist example commands:
#rosie = User.first
# rosie.add_artist("Anthony van Dyck")
# rosie.user_artists
# rosie.user_artists.all