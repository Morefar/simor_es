class AddLesseeToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :lessee_id, :integer
  end
end
