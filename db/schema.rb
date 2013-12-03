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

ActiveRecord::Schema.define(:version => 20131126165001) do

  create_table "accounts", :force => true do |t|
    t.string   "organization_name"
    t.string   "subdomain"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

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
    t.integer  "inspection_count",     :default => 0
    t.date     "last_inspection_date"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "assets", ["body_id"], :name => "index_assets_on_body_id"
  add_index "assets", ["color_id"], :name => "index_assets_on_color_id"
  add_index "assets", ["contract_id"], :name => "index_assets_on_contract_id"
  add_index "assets", ["kind_id"], :name => "index_assets_on_kind_id"
  add_index "assets", ["license_plate"], :name => "index_assets_on_license_plate"
  add_index "assets", ["make_id"], :name => "index_assets_on_make_id"
  add_index "assets", ["model_id"], :name => "index_assets_on_model_id"

  create_table "assignments", :force => true do |t|
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
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

  add_index "builds", ["body_id"], :name => "index_builds_on_body_id"
  add_index "builds", ["kind_id"], :name => "index_builds_on_kind_id"

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  create_table "colors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"

  create_table "contracts", :force => true do |t|
    t.integer  "client_id"
    t.integer  "lessee_id"
    t.string   "number"
    t.integer  "category_id"
    t.date     "start_date"
    t.date     "first_canon_date"
    t.integer  "duration"
    t.integer  "periodicity"
    t.date     "expiration_date"
    t.float    "total_value"
    t.string   "currency"
    t.integer  "asset_count",         :default => 0
    t.text     "location_of_assets"
    t.boolean  "option_to_buy"
    t.date     "last_date_to_option"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "contracts", ["category_id"], :name => "index_contracts_on_category_id"
  add_index "contracts", ["number"], :name => "index_contracts_on_number"

  create_table "cosigners", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "contract_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "cosigners", ["contract_id"], :name => "index_cosigners_on_contract_id"
  add_index "cosigners", ["entity_id"], :name => "index_cosigners_on_entity_id"

  create_table "documents", :force => true do |t|
    t.string   "content"
    t.string   "slug"
    t.string   "md5hash"
    t.string   "content_type"
    t.string   "file_size"
    t.string   "category"
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "documents", ["documentable_id", "documentable_type"], :name => "index_documents_on_documentable_id_and_documentable_type"

  create_table "entities", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "email"
    t.string   "identification_number"
    t.string   "mobile_phone"
    t.string   "name"
    t.string   "phone"
    t.string   "state"
    t.integer  "identification_type_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "entities", ["identification_type_id"], :name => "index_entities_on_identification_type_id"

  create_table "grants", :force => true do |t|
    t.integer  "role_id"
    t.integer  "right_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "grants", ["role_id", "right_id"], :name => "index_grants_on_role_id_and_right_id"

  create_table "identification_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "inspection_orders", :force => true do |t|
    t.string   "contract_url"
    t.string   "asset_unique_identifier"
    t.boolean  "recurring"
    t.integer  "renew_period"
    t.string   "current_status"
    t.text     "notes"
    t.integer  "asset_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "inspections", :force => true do |t|
    t.string   "inspection_number"
    t.integer  "asset_id"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.float    "current_value"
    t.integer  "appraiser_value"
    t.string   "soat_number"
    t.string   "soat_begin_date"
    t.string   "soat_finish_date"
    t.string   "emissions_certificate"
    t.string   "emissions_begin_date"
    t.string   "emissions_finish_date"
    t.string   "exterior"
    t.text     "exterior_notes"
    t.string   "interior"
    t.text     "interior_notes"
    t.string   "engine"
    t.text     "engine_notes"
    t.text     "accesories"
    t.string   "insurance_number"
    t.integer  "insurance_company_id"
    t.integer  "insured_value"
    t.string   "currency"
    t.string   "insurance_start"
    t.string   "insurance_finish"
    t.string   "person_in_charge"
    t.string   "pic_id"
    t.string   "pic_job"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.text     "observations"
    t.boolean  "modifications",         :default => false
    t.string   "odometer",              :default => "0"
    t.datetime "inspection_date"
    t.boolean  "maintenance",           :default => true
    t.boolean  "repairs",               :default => true
    t.boolean  "security",              :default => true
  end

  add_index "inspections", ["asset_id"], :name => "index_inspections_on_asset_id"

  create_table "insurance_companies", :force => true do |t|
    t.string   "name"
    t.string   "nit"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "inventories", :force => true do |t|
    t.integer  "inspection_id"
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
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "inventories", ["inspection_id"], :name => "index_inventories_on_inspection_id"

  create_table "kinds", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "makes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "runt_code"
  end

  add_index "makes", ["runt_code"], :name => "index_makes_on_runt_code"

  create_table "models", :force => true do |t|
    t.integer  "make_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "models", ["make_id"], :name => "index_models_on_make_id"

  create_table "rights", :force => true do |t|
    t.string "resource"
    t.string "operation"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
    t.integer  "account_id"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0,  :null => false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
