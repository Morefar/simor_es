# ## Schema Information
#
# Table name: `categories`
#
# ### Columns
#
# Name        | Type               | Attributes
# ----------- | ------------------ | ---------------------------
# **`id`**    | `integer`          | `not null, primary key`
# **`name`**  | `string(255)`      |
#

FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "contractcategory#{n}" }
  end
end
