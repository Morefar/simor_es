class CreateRights < ActiveRecord::Migration
  def change
    create_table :rights do |t|
      t.string :resource
      t.string :operation
    end
  end
end
