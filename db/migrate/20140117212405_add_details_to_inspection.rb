class AddDetailsToInspection < ActiveRecord::Migration
  def change
    add_belongs_to :inspections, :inspection_order
  end
end
