class AddColumnToInspection < ActiveRecord::Migration
  def change
    add_column :inspections, :overall_condition, :string
  end
end
