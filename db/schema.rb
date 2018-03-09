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

ActiveRecord::Schema.define(version: 20180309014507) do

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "slug"
    t.string "original_guid"
    t.string "original_id"
    t.string "region"
    t.string "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rosters", force: :cascade do |t|
    t.integer "tournament_id"
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_rosters_on_team_id"
    t.index ["tournament_id"], name: "index_rosters_on_tournament_id"
  end

  create_table "standings", force: :cascade do |t|
    t.integer "tournament_id"
    t.integer "team_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_standings_on_team_id"
    t.index ["tournament_id"], name: "index_standings_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "original_id"
    t.string "slug"
    t.string "name"
    t.string "original_guid"
    t.string "logo_url"
    t.string "acronym"
    t.string "bios"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "league_id"
    t.index ["league_id"], name: "index_teams_on_league_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "original_guid"
    t.string "title"
    t.string "description"
    t.integer "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "end_date"
    t.string "start_date"
    t.string "final_standings"
    t.index ["league_id"], name: "index_tournaments_on_league_id"
  end

end
