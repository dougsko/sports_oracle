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

ActiveRecord::Schema.define(version: 20160318164655) do

  create_table "conferences", force: :cascade do |t|
    t.string   "name"
    t.integer  "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "conferences", ["league_id"], name: "index_conferences_on_league_id"

  create_table "divisions", force: :cascade do |t|
    t.string   "name"
    t.integer  "conference_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "divisions", ["conference_id"], name: "index_divisions_on_conference_id"

  create_table "games", force: :cascade do |t|
    t.integer  "week"
    t.integer  "year"
    t.datetime "game_time"
    t.string   "away_team"
    t.string   "home_team"
    t.string   "away_city"
    t.string   "home_city"
    t.string   "away_name"
    t.string   "home_name"
    t.decimal  "away_line"
    t.decimal  "home_line"
    t.integer  "away_score"
    t.integer  "home_score"
    t.string   "away_ats_result"
    t.string   "home_ats_result"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.decimal  "over_under"
    t.string   "over_under_result"
    t.integer  "home_rush_yards"
    t.integer  "away_rush_yards"
    t.integer  "home_pass_yards"
    t.integer  "away_pass_yards"
    t.decimal  "home_qb_rating"
    t.decimal  "away_qb_rating"
    t.integer  "home_receptions"
    t.integer  "away_receptions"
    t.integer  "home_interceptions"
    t.integer  "away_interceptions"
  end

  create_table "leagues", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name"
    t.string   "position"
    t.integer  "number"
    t.string   "status"
    t.integer  "team_id"
    t.integer  "nfl_player_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "stat_entries", force: :cascade do |t|
    t.integer  "week"
    t.integer  "year"
    t.integer  "team_id"
    t.decimal  "value"
    t.integer  "stat_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.decimal  "rating"
    t.decimal  "rating_deviation"
    t.decimal  "volatility"
  end

  add_index "stat_entries", ["stat_id"], name: "index_stat_entries_on_stat_id"

  create_table "stat_lines", force: :cascade do |t|
    t.integer  "nfl_player_id"
    t.integer  "week"
    t.integer  "year"
    t.integer  "rush_atts"
    t.integer  "rush_yards"
    t.integer  "rush_tds"
    t.integer  "fumbles"
    t.integer  "pass_comp"
    t.integer  "pass_att"
    t.integer  "pass_yards"
    t.integer  "pass_tds"
    t.integer  "ints"
    t.decimal  "qb_rating"
    t.integer  "receptions"
    t.integer  "rec_yards"
    t.integer  "rec_tds"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "player_id"
    t.integer  "game_id"
    t.integer  "team_id"
  end

  create_table "stats", force: :cascade do |t|
    t.string   "name"
    t.decimal  "predictive_power"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "home_compare_field"
    t.string   "away_compare_field"
    t.integer  "win_prediction"
    t.integer  "line_prediction"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "city"
    t.integer  "division_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "teams", ["division_id"], name: "index_teams_on_division_id"

end
