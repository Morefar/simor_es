class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :inventory_number
      t.integer :invoice_number
      t.float :value
      t.string :invoice_date
      t.text :description
      t.string :scanned_invoice
      t.integer :contract_id
      t.timestamps
    end
  end
end
