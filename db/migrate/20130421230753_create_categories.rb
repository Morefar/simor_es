class CreateCategories < ActiveRecord::Migration
  def change
      create_table :categories do |cat|
      cat.string :name
    end
  end
end
