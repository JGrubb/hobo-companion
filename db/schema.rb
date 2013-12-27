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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131227192417) do

  create_table "recordings", force: true do |t|
    t.integer  "show_id"
    t.text     "playlist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shows", force: true do |t|
    t.date     "date"
    t.integer  "venue_id"
    t.string   "show_notes",   limit: 1000
    t.boolean  "verified",                  default: false
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "archive_info"
    t.integer  "created_by"
    t.string   "slug"
  end

  add_index "shows", ["slug"], name: "index_shows_on_slug", unique: true, using: :btree
  add_index "shows", ["venue_id"], name: "index_shows_on_venue_id", using: :btree
  add_index "shows", ["verified"], name: "index_shows_on_verified", using: :btree

  create_table "shows_users", id: false, force: true do |t|
    t.integer "show_id"
    t.integer "user_id"
  end

  add_index "shows_users", ["show_id", "user_id"], name: "index_shows_users_on_shows_id_and_users_id", using: :btree

  create_table "songs", force: true do |t|
    t.string   "SongID",       limit: 15
    t.string   "title"
    t.string   "author"
    t.boolean  "is_song",                 default: true
    t.text     "notes"
    t.boolean  "deleted",                 default: false
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.string   "slug"
    t.boolean  "instrumental"
  end

  add_index "songs", ["slug"], name: "index_songs_on_slug", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "is_admin"
    t.boolean  "is_editor"
    t.integer  "karma",                  default: 10
    t.string   "rpx_identifier"
    t.string   "first_name"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "country",    default: "USA"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
  end

  create_table "versions", force: true do |t|
    t.integer  "show_id"
    t.integer  "position"
    t.string   "set_number",             default: "1"
    t.integer  "song_id"
    t.boolean  "transition"
    t.string   "song_notes", limit: 500
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  add_index "versions", ["show_id"], name: "index_on_show_id", using: :btree
  add_index "versions", ["song_id"], name: "index_on_song_id", using: :btree

end
