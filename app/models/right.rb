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

  #-- Relationships --------------------
  has_many :grants
  has_many :roles, through: :grants

  #-- Validations ----------------------
  validates :resource, :operation, presence: true
  validates :operation, inclusion: { in: %w(CREATE READ UPDATE DELETE) }
  validates :operation, uniqueness: { scope: :resource }

  #-- Class constants
  OPERATION_MAPPINGS = {
    "new" => "CREATE",
    "create" => "CREATE",
    "show" => "READ",
    "index" => "READ",
    "edit" => "UPDATE",
    "update" => "UPDATE",
    "destroy" => "DELETE" }
end
