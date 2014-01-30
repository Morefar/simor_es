class ChangeInspectionOrders < ActiveRecord::Migration
  def change
    change_table :inspection_orders do |t|
      t.remove :contract_url
      t.remove :asset_unique_identifier
      t.remove :notes
      t.rename :current_status, :status
    end
  end
end
