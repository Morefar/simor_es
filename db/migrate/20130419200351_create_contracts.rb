class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :client_id
      t.belongs_to :lessee
      t.string :number
      t.references :category
      t.date :start_date
      t.date :first_canon_date
      t.integer :duration
      t.integer :periodicity
      t.date :expiration_date
      t.float :total_value
      t.string :currency
      t.integer :asset_count, default: 0
      t.text :location_of_assets
      t.boolean :option_to_buy
      t.date :last_date_to_option
      t.timestamps
    end
  end
end
