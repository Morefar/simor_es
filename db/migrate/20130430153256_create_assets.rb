class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :inventory_number
      t.string :licence_plate
      t.string :chassis_number
      t.string :cylinder_cap
      t.string :motor_number
      t.integer :capacity
      t.string :color
      t.float :book_value
      t.integer :year
      t.timestamps
    end
  end
end
