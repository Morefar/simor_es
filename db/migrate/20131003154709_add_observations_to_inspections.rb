class AddObservationsToInspections < ActiveRecord::Migration
  def change
    add_column :inspections, :observations, :text
  end
end
