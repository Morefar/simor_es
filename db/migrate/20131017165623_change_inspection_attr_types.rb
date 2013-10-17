class ChangeInspectionAttrTypes < ActiveRecord::Migration
  def up
    remove_column :inspections, :date
    remove_column :inspections, :maintenance
    remove_column :inspections, :repairs
    remove_column :inspections, :security
    add_column :inspections, :inspection_date, :datetime
    add_column :inspections, :maintenance, :boolean, default: true
    add_column :inspections, :repairs, :boolean, default: true
    add_column :inspections, :security, :boolean, default: true
  end

  def down
    remove_column :inspections, :inspection_date
    remove_column :inspections, :maintenance
    remove_column :inspections, :repairs
    remove_column :inspections, :security
    add_column :inspections, :date, :time
    add_column :inspections, :maintenance, :text
    add_column :inspections, :repairs, :text
    add_column :inspections, :security, :text
  end
end
