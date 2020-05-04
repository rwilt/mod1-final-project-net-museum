class CreateUserArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_artworks do |t|
      t.integer :user_id
      t.integer :artwork_id 
    end
  end
end
