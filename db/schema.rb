# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_28_075052) do
  create_table "amenities", force: :cascade do |t|
    t.string "hotel_id", null: false
    t.string "amenity_type"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id", "amenity_type", "name"], name: "index_amenities_on_hotel_id_and_amenity_type_and_name", unique: true
    t.index ["hotel_id"], name: "index_amenities_on_hotel_id"
  end

  create_table "booking_conditions", force: :cascade do |t|
    t.string "hotel_id", null: false
    t.text "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id", "condition"], name: "index_booking_conditions_on_hotel_id_and_condition", unique: true
    t.index ["hotel_id"], name: "index_booking_conditions_on_hotel_id"
  end

  create_table "hotels", id: :string, force: :cascade do |t|
    t.integer "destination_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "hotel_id", null: false
    t.string "image_type"
    t.string "link"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id", "image_type", "link"], name: "index_images_on_hotel_id_and_image_type_and_link", unique: true
    t.index ["hotel_id"], name: "index_images_on_hotel_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "hotel_id", null: false
    t.float "lat"
    t.float "lng"
    t.string "address"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_locations_on_hotel_id"
  end

  add_foreign_key "amenities", "hotels"
  add_foreign_key "booking_conditions", "hotels"
  add_foreign_key "images", "hotels"
  add_foreign_key "locations", "hotels"
end
