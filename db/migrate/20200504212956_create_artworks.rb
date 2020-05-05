class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :department
      t.string :museum, default: "Metropolitan Museum of Art, New York, NY"
      t.string :image
      t.integer :artist_id
  end
  end
end
