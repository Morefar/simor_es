class Document < ActiveRecord::Base
  attr_accessible :category, :description, :file, :title
  belongs_to :documentable, polymorphic: true
  mount_uploader :file, FileUploader

  validates :title, :description, :category, presence: true
end
