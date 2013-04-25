class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :number
      t.integer :category_id
      t.date :start_date
      t.integer :month_duration
      t.date :expiration_date
      t.float :total_value
      t.integer :asset_count
      t.text :location_of_assets
      t.boolean :option_to_buy
      t.date :last_date_to_option
      t.timestamps
    end
  end
end
