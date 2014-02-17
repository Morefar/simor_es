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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :right do
    resource "MyString"
    operation "MyString"
  end
end
