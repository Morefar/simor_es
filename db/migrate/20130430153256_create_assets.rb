class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :contract_id
      t.integer :invoice_id
      t.string :inventory_number
      t.string :licence_plate
      t.string :chassis_number
      t.string :motor_number
      t.string :cylinder_cap
      t.integer :capacity
      t.string :capacity_unit
      t.string :make
      t.string :model
      t.integer :year
      t.string :color
      t.string :build
      t.string :service_type
      t.string :service_mode
      t.string :fuel_type
      t.float :book_value
      t.timestamps
    end
  end
end
