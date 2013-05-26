class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :address
      t.string :city
      t.string :email
      t.string :identification_number
      t.string :mobile_phone
      t.string :name
      t.string :phone
      t.string :state
      t.references :identification_type
      t.timestamps
    end
  end
end
