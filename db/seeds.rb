# require 'pry'
# require 'rest-client'
# require 'json'

# # response = RestClient.get("https://collectionapi.metmuseum.org/public/collection/v1/search?&hasImages=true&q=All?departmentId=5&7&8&21&19&9&14&15&6&11?")
# # metData = JSON.parse(response)

# # # puts data
# # ^^ get the object IDs

# # https://collectionapi.metmuseum.org/public/collection/v1/search?&hasImages=true&q=All?departmentId=21&19&9&14&15&6&11?"
# # ^ this URL link collects from specific departments to cut down my results (dont want to get a bunch of objects etc.)

# # https://collectionapi.metmuseum.org/public/collection/v1/objects/447004

# # ^^ get the actual images



# #         #take my hash of objectIDs(will be much longer in reality)
# #     metData = {"total"=>13536, "objectIDs" =>[464378, 464380]}
    
# #     # hash.each do |k, v|
# #     #   # puts "k is #{k}"
# #     #   # puts "v is #{v}"
# #     # puts hash["objectIDs"]
# #     # end
    
# #     #take my base GET request URL
# #     url = "https://collectionapi.metmuseum.org/public/collection/v1/objects/"
    
# #     urlArray = []
    
# #     #take the objectID hash and iterate through it and add to the end of the URLS. store in an array. 
# #     # def objectHash
# #     metData["objectIDs"].each do |e|
# #     urlArray.push(url.to_s + e.to_s)
# #     end
   
    
# #     # make multiple GET requests from this array and store in a giant hash. 
    
  
# #     finalHash =[]
# #     urlArray.each do |e|
# #     response = RestClient.get(e)
# #     data = JSON.parse(response)
# #     finalHash.push(data)
# #     end
   
# # #  puts finalHash

# response = RestClient.get("https://collectionapi.metmuseum.org/public/collection/v1/search?&hasImages=true&q=All?departmentId=5&6&7&8&9&10&11&13&14&15&17&19&21?")
# $metData = JSON.parse(response)



# def object_id_joiner
# url = "https://collectionapi.metmuseum.org/public/collection/v1/objects/"
# urlArray = []
# $metData["objectIDs"].each do |e|
# urlArray.push(url.to_s + e.to_s)
# end
# urlArray
# end

# # object_id_joiner

# finalHash =[]
#     object_id_joiner.each do |e|
#     response = RestClient.get(e)
#     data = JSON.parse(response)
#     finalHash.push(data)
#     end
   
# #  finalHash

#  finalHash.each do |artist_hash|
#   Artist.create(artist_name:artist_hash["artistDisplayName"])
#   Artwork.create(title: artist_hash["title"],image: artist_hash["primaryImage"], department: artist_hash["department"])

#    end


rosiew = User.create(name: "Rosie", bio: "My favorite department is Egyptian Art, and I love visiting the Cloisters. My favorite artists are Raymond Pettibon and Carrie Mae Weems.")
keanur = User.create(name: "Keanu", bio: "When I'm not at the Continental, the Met is my favorite place to be.")