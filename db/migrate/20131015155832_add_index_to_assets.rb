class AddIndexToAssets < ActiveRecord::Migration
  def change
    add_index :assets, :license_plate
  end
end
