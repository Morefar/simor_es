class AddDetailsToInspections < ActiveRecord::Migration
  def change
    add_column :inspections, :modifications, :boolean, default: false
    add_column :inspections, :odometer, :string, default: 0
  end
end
