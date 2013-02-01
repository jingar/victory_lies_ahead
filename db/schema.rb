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

ActiveRecord::Schema.define(:version => 20130201125750) do

  create_table "heats", :force => true do |t|
    t.datetime "when"
    t.string   "gender"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hurdles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.time     "qualification"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
    t.string   "gender"
  end

  add_index "hurdles", ["user_id", "created_at"], :name => "index_hurdles_on_user_id_and_created_at"

  create_table "match_teams", :force => true do |t|
    t.integer  "team_id"
    t.integer  "match_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "match_teams", ["match_id"], :name => "index_match_teams_on_match_id"
  add_index "match_teams", ["team_id"], :name => "index_match_teams_on_team_id"

  create_table "matches", :force => true do |t|
    t.datetime "when"
    t.string   "opponent"
    t.integer  "pitch"
    t.integer  "umpire_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "matches", ["umpire_id"], :name => "index_matches_on_umpire_id"

  create_table "staffs", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "position"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "user_name"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "staffs", ["remember_token"], :name => "index_staffs_on_remember_token"
  add_index "staffs", ["user_name"], :name => "index_staffs_on_user_name", :unique => true

  create_table "teams", :force => true do |t|
    t.string   "team_name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "teams", ["user_id"], :name => "index_teams_on_user_id"

  create_table "umpires", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "sport"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "telephone"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "wattballs", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "team_id"
  end

end
