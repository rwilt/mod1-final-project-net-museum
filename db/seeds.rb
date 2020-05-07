require 'pry'
require 'rest-client'
require 'json'


###THE BELOW  NEEDS TO BE SEEDED IF YOU DONT HAVE ANY ARTISTS OR ARTWORKS#####
#####################
def object_id_joiner
response = RestClient.get("https://collectionapi.metmuseum.org/public/collection/v1/search?departmentId=11&15&19&21&6q=*")
metData = JSON.parse(response)
url = "https://collectionapi.metmuseum.org/public/collection/v1/objects/"
urlArray = []
metData["objectIDs"].each do |e|
urlArray.push(url.to_s + e.to_s)
end
urlArray.slice!(0,2)
urlArray
end


def finalHash
    finalHash =[]
    object_id_joiner.each do |e|
    response = RestClient.get(e)
    data = JSON.parse(response)
    finalHash.push(data)
    end
    finalHash
  
end


 finalHash.each do |artist_hash|
    if artist_hash["artistDisplayName"] == nil
         next
    end
    
    if (!artist_hash["artistDisplayName"])
    art1 = Artist.create(artist_name:artist_hash["artistDisplayName"]) 
    else 
    next
    end 
    if (!artist_hash["objectID"])
    Artwork.create(title: artist_hash["title"],image: artist_hash["primaryImage"], department: artist_hash["department"], artist: art1, object_id: artist_hash["objectID"])
    else
        next
    end
end


# rosiew = User.create(name: "Rosie", bio: "My favorite department is Egyptian Art, and I love visiting the Cloisters. My favorite artists are Raymond Pettibon and Carrie Mae Weems.")
# keanur = User.create(name: "Keanu", bio: "When I'm not at the Continental, the Met is my favorite place to be.")


