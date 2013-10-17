class ChangeAssignmentsTable < ActiveRecord::Migration
  def change
    remove_index :assignments, [:right_id, :role_id]
    remove_column :assignments, :right_id
    change_table :assignments do |t|
      t.belongs_to :user
    end
  end
end
