# ## Schema Information
#
# Table name: `rights`
#
# ### Columns
#
# Name             | Type               | Attributes
# ---------------- | ------------------ | ---------------------------
# **`id`**         | `integer`          | `not null, primary key`
# **`resource`**   | `string(255)`      |
# **`operation`**  | `string(255)`      |
#

class Right < ActiveRecord::Base
  has_many :grants
  has_many :roles, through: :grants
end
