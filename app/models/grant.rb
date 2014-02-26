# ## Schema Information
#
# Table name: `grants`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`role_id`**     | `integer`          |
# **`right_id`**    | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#

class Grant < ActiveRecord::Base
  #-- Relationships --------------------
  belongs_to :role
  belongs_to :right

  #-- Validations ----------------------
  validates :right, uniqueness: { scope: :role }
end
