class AddColumnsToInspectionOrders < ActiveRecord::Migration
  def change
    add_reference :inspection_orders, :user, index: true
    add_column :inspection_orders, :priority, :string, default: "normal"
    add_index :inspection_orders, :priority
  end
end
