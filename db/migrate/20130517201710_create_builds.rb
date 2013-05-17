class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.integer :kind_id
      t.integer :body_id

      t.timestamps
    end
  end
end
