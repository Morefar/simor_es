class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.references :inspection

      t.timestamps
    end
    add_index :inventories, :inspection_id
  end
end
