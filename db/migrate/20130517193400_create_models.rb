class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.references :make
      t.string :name

      t.timestamps
    end
  end
end
