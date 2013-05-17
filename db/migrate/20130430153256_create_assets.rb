class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :contract_id
      t.integer :invoice_id
      t.string :inventory_number
      t.string :license_plate
      t.integer :make_id
      t.integer :model_id
      t.integer :year
      t.integer :cylinder_cap
      t.string :color_id
      t.string :service_type
      t.integer :kind_id
      t.integer :body_id
      t.string :fuel_type
      t.integer :capacity
      t.string :motor_number
      t.boolean :rerecorded_motor
      t.string :vin
      t.string :serial_number
      t.boolean :rerecorded_serial
      t.string :chassis_number
      t.boolean :rerecorded_chassis
      t.string :mobility_restriction
      t.integer :shield_level
      t.string :horse_power
      t.boolean :importd_assembld
      t.string :import_statement
      t.string :import_date
      t.integer :number_of_doors
      t.string :property_limitation
      t.string :registration_date
      t.string :tp_issue_date
      t.string :tp_expiration_date
      t.string :transit_authority
      t.float :book_value
      t.timestamps
    end
  end
end
