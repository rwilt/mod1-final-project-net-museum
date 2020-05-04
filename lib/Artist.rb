class Artist < ActiveRecord::Base
    has_many :artworks
    has_many :users, through: :user_artists
end