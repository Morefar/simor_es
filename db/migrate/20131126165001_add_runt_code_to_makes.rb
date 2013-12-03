class AddRuntCodeToMakes < ActiveRecord::Migration
  def change
    add_column :makes, :runt_code, :integer
    add_index :makes, :runt_code
  end
end
