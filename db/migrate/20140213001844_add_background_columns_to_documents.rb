class AddBackgroundColumnsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :content_processing, :boolean
  end
end
