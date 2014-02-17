# ## Schema Information
#
# Table name: `insurance_companies`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`nit`**         | `string(255)`      |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#

class InsuranceCompany < ActiveRecord::Base
  has_many :inspections

  validates :name, :nit, presence: true
  validates :name, :nit, uniqueness: true
  validates :name, format: { with: /\A[\D]+[a-z.]+\Z/i }
  validates :nit, format: { with: /\A\d{3}([.]*)\d{3}\1\d{3}\Z/ }
  validates :nit, length: { within: 9..11 }
end
