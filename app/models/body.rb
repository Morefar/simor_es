# ## Schema Information
#
# Table name: `bodies`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#


class Body < ActiveRecord::Base
  has_many :builds
  has_many :kinds, through: :builds

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, format: { with: /\A[\p{L}\p{P}\+\d\s]+\Z/iu }
  default_scope { order(:name) }
  scope :search_name, ->(name) { where("name ilike ?", name) }
end
