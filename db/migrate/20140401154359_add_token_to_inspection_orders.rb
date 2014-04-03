class AddTokenToInspectionOrders < ActiveRecord::Migration
  def change
    add_column :inspection_orders, :token, :string
    add_index :inspection_orders, :token, unique: true, name: "by_uniq_token", length: 22
  end
end
