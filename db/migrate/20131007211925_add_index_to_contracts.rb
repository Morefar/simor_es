class AddIndexToContracts < ActiveRecord::Migration
  def change
    add_index :contracts, :number, unique: true
  end
end
