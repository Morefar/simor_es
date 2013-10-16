class CreateGrants < ActiveRecord::Migration
  def change
    create_table :grants do |t|
      t.belongs_to :role
      t.belongs_to :right
      t.timestamps
    end
    add_index :grants, [:role_id, :right_id]
  end
end
