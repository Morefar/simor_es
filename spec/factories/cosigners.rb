# ## Schema Information
#
# Table name: `cosigners`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `integer`          | `not null, primary key`
# **`entity_id`**    | `integer`          |
# **`contract_id`**  | `integer`          |
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cosigner do
    entity { create(:entity) }
    contract { create(:contract) }
  end
end
