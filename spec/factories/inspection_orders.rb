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
    recurring true
    renew_period 6
    status "generated"
    priority "normal"
    user_id 1
  end
end
