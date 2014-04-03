# ## Schema Information
#
# Table name: `models`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`make_id`**     | `integer`          |
# **`name`**        | `string(255)`      |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#

class Model < ActiveRecord::Base
  #-- Relationships --------------------
  belongs_to :make, inverse_of: :models

  #-- Delegations ----------------------
  delegate :name, to: :make, prefix: true, allow_nil: true

  #-- Scopes ---------------------------
  default_scope { order(:make_id, :name) }
  scope :search_name, ->(name) { where("name ilike ?", name) }

  #-- Validations ----------------------
  validates :name, presence: true
  validates :name, format: { with: /\A[\p{L}\p{P}\+\d\s]+\Z/iu }
  validates :name, uniqueness: { scope: :make_id }

  #-- Class methods --------------------
  def self.policy_class
    ModelPolicy
  end
end
