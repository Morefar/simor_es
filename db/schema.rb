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

ActiveRecord::Schema.define(:version => 20130430153256) do

  create_table "assets", :force => true do |t|
    t.integer  "contract_id"
    t.integer  "invoice_id"
    t.string   "inventory_number"
    t.string   "license_plate"
    t.string   "chassis_number"
    t.string   "motor_number"
    t.string   "cylinder_cap"
    t.integer  "capacity"
    t.string   "capacity_unit"
    t.string   "make"
    t.string   "model"
    t.integer  "year"
    t.string   "color"
    t.string   "build"
    t.string   "service_type"
    t.string   "service_mode"
    t.string   "fuel_type"
    t.float    "book_value"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  create_table "contracts", :force => true do |t|
    t.integer  "client_id"
    t.string   "number"
    t.integer  "category_id"
    t.date     "start_date"
    t.date     "first_canon_date"
    t.integer  "duration"
    t.integer  "periodicity"
    t.date     "expiration_date"
    t.float    "total_value"
    t.string   "currency"
    t.integer  "asset_count"
    t.text     "location_of_assets"
    t.boolean  "option_to_buy"
    t.date     "last_date_to_option"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

end
