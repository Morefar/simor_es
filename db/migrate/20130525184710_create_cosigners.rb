class CreateCosigners < ActiveRecord::Migration
  def change
    create_table :cosigners do |t|
      t.references :entity
      t.references :contract

      t.timestamps
    end
  end
end
