class CreateCosigners < ActiveRecord::Migration
  def change
    create_table :cosigners do |t|
      t.references :entity
      t.references :contract

      t.timestamps
    end
    add_index :cosigners, :entity_id
    add_index :cosigners, :contract_id
  end
end
