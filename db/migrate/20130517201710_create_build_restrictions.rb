class CreateBuildRestrictions < ActiveRecord::Migration
  def change
    create_table :build_restrictions do |t|
      t.integer :kind_id
      t.integer :body_id

      t.timestamps
    end
  end
end
