# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_04_215051) do

  create_table "artists", force: :cascade do |t|
    t.string "artist_name"
  end

  create_table "artworks", force: :cascade do |t|
    t.string "title"
    t.string "department"
    t.string "museum", default: "Metropolitan Museum of Art, New York, NY"
    t.string "image"
    t.integer "object_id"
    t.integer "artist_id"
  end

  create_table "user_artists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "artist_id"
  end

  create_table "user_artworks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "artwork_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "bio"
  end

end
