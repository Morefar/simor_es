# ## Schema Information
#
# Table name: `assignments`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`role_id`**     | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`user_id`**     | `integer`          |
#

class Assignment < ActiveRecord::Base

  #-- Relationships --------------------
  belongs_to :user
  belongs_to :role

  #-- Validations ----------------------
  validates :user, :role, presence: true
  validates :role, uniqueness: { scope: :user }
end
