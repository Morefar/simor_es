class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.references :kind
      t.references :body

      t.timestamps
    end
  end
end
