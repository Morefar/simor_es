class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :file
      t.string :title
      t.string :description
      t.string :category
      t.belongs_to :documentable, polymorphic: true

      t.timestamps
    end
    add_index :documents, [:documentable_id, :documentable_type]
  end
end
