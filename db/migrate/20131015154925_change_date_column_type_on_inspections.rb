class ChangeDateColumnTypeOnInspections < ActiveRecord::Migration
  def change
    remove_column :inspections, :date
    remove_column :inspections, :maintenance
    remove_column :inspections, :repairs
    remove_column :inspection, :security
    add_column :inspections, :inspection_date, :datetime
    add_column :inspections, :maintenance, :boolean, default: true
    add_column :inspections, :repairs, :boolean, default: true
    add_column :inspection, :security, :boolean, default: true
  end
end
