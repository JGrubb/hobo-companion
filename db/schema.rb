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

ActiveRecord::Schema.define(:version => 20130402180250) do

  create_table "shows", :force => true do |t|
    t.date    "date"
    t.integer "venue_id"
    t.string  "show_notes", :limit => 1000
  end

  add_index "shows", ["venue_id"], :name => "index_shows_on_venue_id"

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

  create_table "songs", :force => true do |t|
    t.string  "SongID",  :limit => 15
    t.string  "title"
    t.string  "author"
    t.boolean "is_song",               :default => true
    t.text    "notes"
    t.boolean "deleted",               :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "is_admin"
    t.boolean  "is_editor"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "venues", :force => true do |t|
    t.string "name"
    t.string "city"
    t.string "state"
    t.string "country", :default => "USA"
  end

end
