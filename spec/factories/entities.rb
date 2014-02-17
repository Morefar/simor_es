# ## Schema Information
#
# Table name: `entities`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`address`**                 | `string(255)`      |
# **`city`**                    | `string(255)`      |
# **`email`**                   | `string(255)`      |
# **`identification_number`**   | `string(255)`      |
# **`mobile_phone`**            | `string(255)`      |
# **`name`**                    | `string(255)`      |
# **`phone`**                   | `string(255)`      |
# **`state`**                   | `string(255)`      |
# **`identification_type_id`**  | `integer`          |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
#

require 'faker'
FactoryGirl.define do
  factory :entity, aliases: [:lessee] do
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    email { Faker::Internet.email }
    sequence (:identification_number) { |n| "289.988.#{n}-5" }
    identification_type
    mobile_phone { Faker::PhoneNumber.cell_phone }
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    state { Faker::Address.state }
      factory :invalid_entity do
        name nil
        identification_type nil
        identification_number nil
      end
  end
end
