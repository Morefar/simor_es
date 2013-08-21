class Document < ActiveRecord::Base
  attr_accessible :category, :content, :slug, :documentable_id, :documentable_type
  belongs_to :documentable, polymorphic: true
  mount_uploader :content, DocumentUploader

  before_validation :compute_hash

  validates :slug, :md5hash, :category, :content, presence: true
  validates :md5hash, uniqueness: true

  before_save :update_document_attributes

  private
  def update_document_attributes
    if content.present? && content_changed?
      self.content_type = content.file.content_type
      self.file_size = content.file.size
    end
  end

  def compute_hash
    self.md5hash = Digest::MD5.hexdigest(self.content.read) unless
    content.read.nil?  end

end
