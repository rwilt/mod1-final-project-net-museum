class Artwork < ActiveRecord::Base
    belongs_to :artist
    has_many :user_artworks
    has_many :users, through: :user_artworks
end
