# ## Schema Information
#
# Table name: `contracts`
#
# ### Columns
#
# Name                       | Type               | Attributes
# -------------------------- | ------------------ | ---------------------------
# **`id`**                   | `integer`          | `not null, primary key`
# **`client_id`**            | `integer`          |
# **`lessee_id`**            | `integer`          |
# **`number`**               | `string(255)`      |
# **`category_id`**          | `integer`          |
# **`start_date`**           | `date`             |
# **`first_canon_date`**     | `date`             |
# **`duration`**             | `integer`          |
# **`periodicity`**          | `integer`          |
# **`expiration_date`**      | `date`             |
# **`total_value`**          | `float`            |
# **`currency`**             | `string(255)`      |
# **`asset_count`**          | `integer`          | `default(0)`
# **`location_of_assets`**   | `text`             |
# **`option_to_buy`**        | `boolean`          |
# **`last_date_to_option`**  | `date`             |
# **`created_at`**           | `datetime`         | `not null`
# **`updated_at`**           | `datetime`         | `not null`
#

FactoryGirl.define do
  factory :contract do
    sequence (:client_id) { |n| n }
    lessee
    sequence (:number) { |n| "10980984-987#{n}"}
    category
    start_date Date.current
    first_canon_date { start_date >> ([0, 1].sample) }
    duration [6, 12, 24, 48, 60].sample
    periodicity [1, 3, 6, 12].sample
    expiration_date { first_canon_date >> (duration * periodicity) }
    total_value Random.rand(2_000_000.00..500_000_000.00)
    currency 'COP'
    location_of_assets 'CHICAGO'
  end

  factory :invalid_contract do
    lessee nil
  end
end
