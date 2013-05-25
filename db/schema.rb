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

ActiveRecord::Schema.define(:version => 20130525180837) do

  create_table "assets", :force => true do |t|
    t.integer  "contract_id"
    t.integer  "invoice_id"
    t.string   "inventory_number"
    t.string   "transit_permit"
    t.string   "license_plate"
    t.integer  "make_id"
    t.integer  "model_id"
    t.integer  "year"
    t.integer  "cylinder_cap"
    t.integer  "color_id"
    t.string   "service_type"
    t.integer  "kind_id"
    t.integer  "body_id"
    t.string   "fuel_type"
    t.integer  "capacity"
    t.string   "motor_number"
    t.boolean  "rerecorded_motor"
    t.string   "vin"
    t.string   "serial_number"
    t.boolean  "rerecorded_serial"
    t.string   "chassis_number"
    t.boolean  "rerecorded_chassis"
    t.string   "mobility_restriction"
    t.integer  "shield_level"
    t.string   "horse_power"
    t.boolean  "importd_assembld"
    t.string   "import_statement"
    t.string   "import_date"
    t.integer  "number_of_doors"
    t.string   "property_limitation"
    t.string   "registration_date"
    t.string   "tp_issue_date"
    t.string   "tp_expiration_date"
    t.string   "transit_authority"
    t.float    "book_value"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "bodies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "builds", :force => true do |t|
    t.integer  "kind_id"
    t.integer  "body_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "business_entities", :force => true do |t|
    t.string   "name"
    t.integer  "id_type_id"
    t.string   "id_number"
    t.string   "address"
    t.string   "phone"
    t.string   "city"
    t.string   "state"
    t.string   "mobile_phone"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "business_entities", ["id_type_id"], :name => "index_business_entities_on_id_type_id"

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  create_table "colors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.integer  "lessee_id"
  end

  create_table "id_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "inspections", :force => true do |t|
    t.integer  "asset_id"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.time     "date"
    t.float    "current_value"
    t.integer  "appraiser_value"
    t.string   "soat_number"
    t.string   "soat_begin_date"
    t.string   "soat_finish_date"
    t.string   "gas_certificate"
    t.string   "gas_begin_date"
    t.string   "gas_finish_date"
    t.string   "maintenance"
    t.string   "repairs"
    t.string   "security"
    t.string   "exterior"
    t.string   "interior"
    t.string   "engine"
    t.string   "accesories"
    t.string   "insurance_number"
    t.string   "insurance_company"
    t.string   "insured_value"
    t.string   "currency"
    t.string   "insurance_start"
    t.string   "insurance_finish"
    t.string   "person_in_charge"
    t.string   "pic_id"
    t.string   "pic_job"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "inventories", :force => true do |t|
    t.integer  "inspection_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.boolean  "kilometers"
    t.boolean  "villare"
    t.boolean  "glove_compartment"
    t.boolean  "dashboard"
    t.boolean  "right_seat"
    t.boolean  "left_seat"
    t.boolean  "back_seat"
    t.boolean  "third_row"
    t.boolean  "courtesy_light"
    t.boolean  "seat_belt"
    t.string   "radio_brand"
    t.boolean  "cd_player"
    t.integer  "speakers"
    t.boolean  "lighter"
    t.integer  "ash_trays"
    t.boolean  "clock"
    t.integer  "door_panels"
    t.integer  "rearview_mirrors"
    t.integer  "head_rest"
    t.boolean  "handles"
    t.boolean  "horn"
    t.integer  "side_mirrors"
    t.boolean  "warranty_book"
    t.boolean  "driver_manual"
    t.boolean  "ignition"
    t.boolean  "battery"
    t.boolean  "engine_operation"
    t.boolean  "uniq_form"
    t.boolean  "tax_receipt"
    t.boolean  "lights"
    t.boolean  "directional_signals"
    t.boolean  "external_fog_lights"
    t.boolean  "blind"
    t.boolean  "front_bumper"
    t.boolean  "hood"
    t.boolean  "wiper_blades"
    t.boolean  "front_right_fender"
    t.boolean  "front_right_door"
    t.boolean  "back_right_door"
    t.boolean  "right_stirrup"
    t.boolean  "back_right_fender"
    t.boolean  "back_bumper"
    t.boolean  "trunk_door"
    t.boolean  "back_left_fender"
    t.boolean  "back_left_door"
    t.boolean  "front_left_door"
    t.boolean  "left_stirrup"
    t.boolean  "canvas_hood"
    t.boolean  "top"
    t.boolean  "jack"
    t.boolean  "bolt_wrench"
    t.integer  "tool_kit"
    t.integer  "tool_keys"
    t.boolean  "front_tires"
    t.boolean  "back_tires"
    t.boolean  "spare_tires"
    t.integer  "common_rims"
    t.integer  "luxury_rims"
    t.integer  "cups"
    t.boolean  "front_windshield"
    t.boolean  "front_right_window"
    t.boolean  "rear_right_window"
    t.boolean  "third_rear_right_window"
    t.boolean  "rear_windshield"
    t.boolean  "rear_left_window"
    t.boolean  "front_left_window"
    t.boolean  "third_rear_left_window"
    t.boolean  "air_conditioner"
    t.integer  "electric_windows"
    t.integer  "central_block"
    t.boolean  "sun_roof"
    t.boolean  "luxury_steering_wheel"
    t.integer  "floor_mats"
    t.integer  "triangles"
    t.boolean  "first_aid_kit"
    t.boolean  "leather_upholstery"
    t.boolean  "pijama"
    t.boolean  "trunk_cover"
    t.boolean  "celular_phone"
    t.boolean  "electric_antena"
    t.boolean  "antena"
    t.text     "observations"
  end

  add_index "inventories", ["inspection_id"], :name => "index_inventories_on_inspection_id"

  create_table "invoices", :force => true do |t|
    t.string   "number"
    t.string   "import_manifest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "kinds", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "leesse_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "leesses", :force => true do |t|
    t.integer  "leesse_type_id"
    t.integer  "contract_id"
    t.integer  "business_entity_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "leesses", ["business_entity_id"], :name => "index_leesses_on_business_entity_id"
  add_index "leesses", ["contract_id"], :name => "index_leesses_on_contract_id"
  add_index "leesses", ["leesse_type_id"], :name => "index_leesses_on_leesse_type_id"

  create_table "makes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "models", :force => true do |t|
    t.integer  "make_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
