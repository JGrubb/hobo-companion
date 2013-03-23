# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130323111027) do

  create_table "shows", :force => true do |t|
    t.date    "date"
    t.integer "venue_id"
    t.string  "show_notes", :limit => 1000
  end

  create_table "song_instances", :force => true do |t|
    t.integer "show_id"
    t.integer "position"
    t.string  "set_number", :limit => 16
    t.integer "song_id"
    t.boolean "transition"
    t.string  "song_notes", :limit => 500
  end

  add_index "song_instances", ["show_id"], :name => "index_on_show_id"
  add_index "song_instances", ["song_id"], :name => "index_on_song_id"

  create_table "song_instances_old", :id => false, :force => true do |t|
    t.integer "ShowID",                                       :null => false
    t.integer "SongNumber",                                   :null => false
    t.string  "Set",        :limit => 10,                     :null => false
    t.string  "SongID",     :limit => 15,                     :null => false
    t.boolean "Transition",                :default => false
    t.string  "SongNotes",  :limit => 500
  end

  add_index "song_instances_old", ["ShowID"], :name => "fkShowID_idx"
  add_index "song_instances_old", ["SongID"], :name => "fkSongID_idx"

  create_table "song_int_copy", :id => false, :force => true do |t|
    t.integer "ShowID",                    :null => false
    t.integer "SongNumber"
    t.string  "set_number", :limit => 10
    t.string  "SongID",     :limit => 15
    t.boolean "Transition"
    t.string  "SongNotes",  :limit => 500
  end

  create_table "songs", :force => true do |t|
    t.string  "SongID",  :limit => 15
    t.string  "title"
    t.string  "author"
    t.boolean "is_song"
    t.text    "notes"
  end

  create_table "venues", :force => true do |t|
    t.string "name"
    t.string "city"
    t.string "state"
    t.string "country", :default => "USA"
  end

end
