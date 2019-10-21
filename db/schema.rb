# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_21_015740) do

  create_table "bands", force: :cascade do |t|
    t.string "name"
    t.string "genre"
    t.string "popularity"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "state"
  end

  create_table "shows", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "venue_id"
    t.integer "band_id"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "neighborhood"
    t.string "size"
    t.integer "city_id"
  end

end
