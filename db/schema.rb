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

ActiveRecord::Schema.define(version: 20170223143350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shows", force: :cascade do |t|
    t.date     "date"
    t.integer  "venue_id"
    t.string   "show_notes",   limit: 4000
    t.boolean  "verified",                  default: false
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "archive_info"
    t.integer  "created_by"
    t.string   "slug",         limit: 255
  end

  add_index "shows", ["slug"], name: "index_shows_on_slug", unique: true, using: :btree
  add_index "shows", ["venue_id"], name: "index_shows_on_venue_id", using: :btree
  add_index "shows", ["verified"], name: "index_shows_on_verified", using: :btree

  create_table "shows_users", id: false, force: :cascade do |t|
    t.integer "show_id"
    t.integer "user_id"
  end

  add_index "shows_users", ["show_id", "user_id"], name: "index_shows_users_on_shows_id_and_users_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.string   "author",         limit: 255
    t.boolean  "is_song",                    default: true
    t.text     "notes"
    t.boolean  "deleted",                    default: false
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.string   "slug",           limit: 255
    t.boolean  "instrumental"
    t.integer  "versions_count",             default: 0
  end

  add_index "songs", ["slug"], name: "index_songs_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,              null: false
    t.string   "encrypted_password",     limit: 255,              null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.boolean  "is_admin"
    t.boolean  "is_editor"
    t.integer  "karma",                              default: 10
    t.string   "rpx_identifier",         limit: 255
    t.string   "first_name",             limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.string   "country",    limit: 255, default: "USA"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
  end

  create_table "versions", force: :cascade do |t|
    t.integer  "show_id"
    t.integer  "position"
    t.string   "set_number", limit: 255, default: "1"
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
