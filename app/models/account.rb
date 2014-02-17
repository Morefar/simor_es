# ## Schema Information
#
# Table name: `accounts`
#
# ### Columns
#
# Name                     | Type               | Attributes
# ------------------------ | ------------------ | ---------------------------
# **`id`**                 | `integer`          | `not null, primary key`
# **`organization_name`**  | `string(255)`      |
# **`subdomain`**          | `string(255)`      |
# **`created_at`**         | `datetime`         |
# **`updated_at`**         | `datetime`         |
#

class Account < ActiveRecord::Base
  has_many :users
  validates :organization_name, :subdomain, presence: true
  validates :subdomain, format: { with: /\A[\p{Ll}\p{Pd}]+\d*\Z/iu }
end
