require_relative '../config/environment'
require 'asciiart'
require 'rmagick'

a = AsciiArt.new("https://upload.wikimedia.org/wikipedia/commons/d/d7/Meisje_met_de_parel.jpg")
  #<AsciiArt:0x00000100878678 @file=#<File:/Users/sschor/Desktop/uncle_larry.jpg>>
 puts a.to_ascii_art(color: true, width:100)

puts "Terminal Art Gallery"
