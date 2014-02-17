# ## Schema Information
#
# Table name: `identification_types`
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

class IdentificationType < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}
  validates :name, format: { with: /\A[a-zA-Z0-9]+\Z/ }
end
