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

require 'faker'
FactoryGirl.define do
  factory :account do
    organization_name { "#{Faker::Company.name} #{ Faker::Company.suffix }" }
    subdomain { organization_name.parameterize }
  end
end
