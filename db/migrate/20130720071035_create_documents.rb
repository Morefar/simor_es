class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :content
      t.string :slug
      t.string :md5hash
      t.string :content_type
      t.string :file_size
      t.string :category
      t.belongs_to :documentable, polymorphic: true

      t.timestamps
    end
    add_index :documents, [:documentable_id, :documentable_type]
  end
end
