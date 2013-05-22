class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :contract
      t.references :invoice
      t.string :inventory_number
      t.string :transit_permit
      t.string :license_plate
      t.references :make
      t.references :model
      t.integer :year
      t.integer :cylinder_cap
      t.references :color
      t.string :service_type
      t.references :kind
      t.references :body
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
