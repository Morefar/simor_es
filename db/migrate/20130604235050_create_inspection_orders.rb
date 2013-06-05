class CreateInspectionOrders < ActiveRecord::Migration
  def change
    create_table :inspection_orders do |t|
      t.string :contract_url
      t.string :asset_unique_identifier
      t.boolean :recurring
      t.integer :renew_period
      t.string :current_status
      t.text :notes

      t.timestamps
    end
  end
end
