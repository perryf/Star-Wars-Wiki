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

ActiveRecord::Schema.define(version: 20170808003816) do

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
    t.string "classification", default: ""
    t.string "birth_year"
    t.integer "height"
    t.integer "mass"
    t.string "vehicles"
    t.text "bio", default: ""
    t.string "catch_phrase", default: ""
    t.string "img_url"
    t.string "films"
    t.string "url"
    t.bigint "alliance_id"
    t.bigint "homeworld_id"
    t.bigint "species_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alliance_id"], name: "index_characters_on_alliance_id"
    t.index ["homeworld_id"], name: "index_characters_on_homeworld_id"
    t.index ["species_id"], name: "index_characters_on_species_id"
  end

  create_table "homeworlds", force: :cascade do |t|
    t.string "name", null: false
    t.string "bio"
    t.string "img_url"
    t.string "climate"
    t.string "terrain"
    t.bigint "population"
    t.string "gravity"
    t.string "films"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "species", force: :cascade do |t|
    t.string "name"
    t.string "img_url"
    t.string "designation"
    t.string "classification"
    t.integer "average_height"
    t.integer "average_lifespan"
    t.string "skin_colors"
    t.string "language"
    t.string "films"
    t.string "url"
    t.bigint "homeworld_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["homeworld_id"], name: "index_species_on_homeworld_id"
  end

  create_table "transportations", force: :cascade do |t|
    t.bigint "vehicle_id", null: false
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_transportations_on_character_id"
    t.index ["vehicle_id"], name: "index_transportations_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "name"
    t.string "model"
    t.string "manufacturer"
    t.integer "cost_in_credits"
    t.integer "cargo_capacity"
    t.string "vehicle_class"
    t.string "max_atmosphering_speed"
    t.integer "crew"
    t.integer "passengers"
    t.float "length"
    t.string "films"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "characters", "alliances"
  add_foreign_key "characters", "homeworlds"
  add_foreign_key "characters", "species"
  add_foreign_key "species", "homeworlds"
  add_foreign_key "transportations", "characters"
  add_foreign_key "transportations", "vehicles"
end
