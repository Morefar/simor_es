class AddDetailsToInspectionOrders < ActiveRecord::Migration
  def up
    change_table :inspection_orders do |t|
      t.change_default :recurring, false
      t.date :scheduled_date
    end
  end

  def down
    change_table :inspection_orders do |t|
      t.remove :scheduled_date
    end
  end
end
