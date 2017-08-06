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

ActiveRecord::Schema.define(version: 20170806162005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alliances", force: :cascade do |t|
    t.string "name", null: false
    t.string "img_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string "name", null: false
    t.string "species"
    t.string "classification", default: ""
    t.string "birth_year"
    t.string "height"
    t.string "mass"
    t.string "homeworld"
    t.string "vehicles"
    t.text "bio", default: ""
    t.string "catch_phrase", default: ""
    t.string "img_url"
    t.string "films"
    t.bigint "alliance_id"
    t.bigint "homeworld_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alliance_id"], name: "index_characters_on_alliance_id"
    t.index ["homeworld_id"], name: "index_characters_on_homeworld_id"
  end

  create_table "homeworlds", force: :cascade do |t|
    t.string "name", null: false
    t.string "climate"
    t.string "terrain"
    t.string "population"
    t.string "gravity"
    t.string "films"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "characters", "alliances"
  add_foreign_key "characters", "homeworlds"
end
