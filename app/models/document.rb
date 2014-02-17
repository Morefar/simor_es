# ## Schema Information
#
# Table name: `documents`
#
# ### Columns
#
# Name                      | Type               | Attributes
# ------------------------- | ------------------ | ---------------------------
# **`id`**                  | `integer`          | `not null, primary key`
# **`content`**             | `string(255)`      |
# **`slug`**                | `string(255)`      |
# **`md5hash`**             | `string(255)`      |
# **`content_type`**        | `string(255)`      |
# **`file_size`**           | `string(255)`      |
# **`category`**            | `string(255)`      |
# **`documentable_id`**     | `integer`          |
# **`documentable_type`**   | `string(255)`      |
# **`created_at`**          | `datetime`         | `not null`
# **`updated_at`**          | `datetime`         | `not null`
# **`content_processing`**  | `boolean`          |
#

class Document < ActiveRecord::Base
  belongs_to :documentable, polymorphic: true
  mount_uploader :content, DocumentUploader
  process_in_background :content

  before_validation :compute_hash

  validates :md5hash, :content, presence: true
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
    self.md5hash = content.md5
  end
end
