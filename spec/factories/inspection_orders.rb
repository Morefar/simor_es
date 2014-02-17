# ## Schema Information
#
# Table name: `inspection_orders`
#
# ### Columns
#
# Name                  | Type               | Attributes
# --------------------- | ------------------ | ---------------------------
# **`id`**              | `integer`          | `not null, primary key`
# **`recurring`**       | `boolean`          | `default(FALSE)`
# **`renew_period`**    | `integer`          |
# **`status`**          | `string(255)`      |
# **`asset_id`**        | `integer`          |
# **`created_at`**      | `datetime`         | `not null`
# **`updated_at`**      | `datetime`         | `not null`
# **`scheduled_date`**  | `date`             |
# **`user_id`**         | `integer`          |
# **`priority`**        | `string(255)`      | `default("normal")`
#

# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :inspection_order do
    contract_url "https://www.example.com/contracts/"
    asset_unique_identifier 'CDV130'
    recurring true
    renew_period 6
    current_status %w(OPEN ASSIGNED PENDING CLOSED).sample
    notes Faker::Lorem.paragraph 20
  end
end
