class AddIndexToContracts < ActiveRecord::Migration
  def change
    add_index :contracts, :number, uniqueness: true
  end
end
