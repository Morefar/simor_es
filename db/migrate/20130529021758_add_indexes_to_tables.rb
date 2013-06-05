class AddIndexesToTables < ActiveRecord::Migration
  def change
    add_index :contracts, :category_id
    add_index :assets, :contract_id
    add_index :assets, :make_id
    add_index :assets, :model_id
    add_index :assets, :color_id
    add_index :assets, :kind_id
    add_index :assets, :body_id
    add_index :models, :make_id
    add_index :builds, :kind_id
    add_index :builds, :body_id
    add_index :inspections, :asset_id
    add_index :inventories, :inspection_id
    add_index :entities, :identification_type_id
    add_index :cosigners, :entity_id
    add_index :cosigners, :contract_id
  end
end
