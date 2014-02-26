# ## Schema Information
#
# Table name: `roles`
#
# ### Columns
#
# Name        | Type               | Attributes
# ----------- | ------------------ | ---------------------------
# **`id`**    | `integer`          | `not null, primary key`
# **`name`**  | `string(255)`      |
#

class Role < ActiveRecord::Base

  #-- Relationships --------------------
  has_many :assignments
  has_many :grants
  has_many :users, through: :assignments
  has_many :rights, through: :grants

  #-- Validations ----------------------
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: true }

end
