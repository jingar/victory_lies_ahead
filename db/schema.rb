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

ActiveRecord::Schema.define(:version => 20130303210107) do

  create_table "heat_hurdles", :force => true do |t|
    t.integer  "heat_id"
    t.integer  "hurdle_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.time     "finish_time"
  end

  add_index "heat_hurdles", ["heat_id"], :name => "index_heat_hurdles_on_heat_id"
  add_index "heat_hurdles", ["hurdle_id"], :name => "index_heat_hurdles_on_hurdle_id"

  create_table "heats", :force => true do |t|
    t.string   "gender"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.datetime "time"
    t.integer  "round"
    t.integer  "tournament_id"
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
    t.string   "homeTeam"
    t.string   "awayTeam"
    t.integer  "pitch"
    t.string   "umpire"
    t.integer  "homeGoals"
    t.integer  "awayGoals"
    t.integer  "team_id_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "umpire_id"
    t.integer  "team_id"
  end

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
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "match_teams_id"
    t.integer  "wins",              :default => 0
    t.integer  "draws",             :default => 0
    t.integer  "losses",            :default => 0
    t.integer  "goalsfor",          :default => 0
    t.integer  "goalsagainst",      :default => 0
    t.integer  "number_of_players"
  end

  add_index "teams", ["user_id"], :name => "index_teams_on_user_id"

  create_table "tickets", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "address"
    t.string   "order_id"
    t.integer  "tickets_bought"
    t.boolean  "used"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "tournaments", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "umpires", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "umpire_id"
    t.integer  "match_id"
  end

  add_index "umpires", ["umpire_id"], :name => "index_umpires_on_umpire_id", :unique => true

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
