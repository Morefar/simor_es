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

require 'faker'

FactoryGirl.define do
  factory :insurance_company do
    name {"#{Faker::Company.name} #{Faker::Company.suffix}"}
    sequence(:nit) { |n| "234.355.2#{n+10}"}
  end
end
