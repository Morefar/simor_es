class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.belongs_to :right
      t.belongs_to :role
      t.timestamps
    end
    add_index :assignments, [:right_id, :role_id]
  end
end
