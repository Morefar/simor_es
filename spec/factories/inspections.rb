# ## Schema Information
#
# Table name: `inspections`
#
# ### Columns
#
# Name                         | Type               | Attributes
# ---------------------------- | ------------------ | ---------------------------
# **`id`**                     | `integer`          | `not null, primary key`
# **`inspection_number`**      | `string(255)`      |
# **`asset_id`**               | `integer`          |
# **`address`**                | `string(255)`      |
# **`city`**                   | `string(255)`      |
# **`state`**                  | `string(255)`      |
# **`current_value`**          | `float`            |
# **`appraiser_value`**        | `integer`          |
# **`soat_number`**            | `string(255)`      |
# **`soat_begin_date`**        | `string(255)`      |
# **`soat_finish_date`**       | `string(255)`      |
# **`emissions_certificate`**  | `string(255)`      |
# **`emissions_begin_date`**   | `string(255)`      |
# **`emissions_finish_date`**  | `string(255)`      |
# **`exterior`**               | `string(255)`      |
# **`exterior_notes`**         | `text`             |
# **`interior`**               | `string(255)`      |
# **`interior_notes`**         | `text`             |
# **`engine`**                 | `string(255)`      |
# **`engine_notes`**           | `text`             |
# **`accesories`**             | `text`             |
# **`insurance_number`**       | `string(255)`      |
# **`insurance_company_id`**   | `integer`          |
# **`insured_value`**          | `integer`          |
# **`currency`**               | `string(255)`      |
# **`insurance_start`**        | `string(255)`      |
# **`insurance_finish`**       | `string(255)`      |
# **`person_in_charge`**       | `string(255)`      |
# **`pic_id`**                 | `string(255)`      |
# **`pic_job`**                | `string(255)`      |
# **`created_at`**             | `datetime`         | `not null`
# **`updated_at`**             | `datetime`         | `not null`
# **`observations`**           | `text`             |
# **`modifications`**          | `boolean`          | `default(FALSE)`
# **`odometer`**               | `string(255)`      | `default("0")`
# **`inspection_date`**        | `datetime`         |
# **`maintenance`**            | `boolean`          | `default(TRUE)`
# **`repairs`**                | `boolean`          | `default(TRUE)`
# **`security`**               | `boolean`          | `default(TRUE)`
# **`inspection_order_id`**    | `integer`          |
# **`overall_condition`**      | `string(255)`      |
#

require 'faker'
FactoryGirl.define do
  factory :inspection do
    asset { create(:asset) }
    sequence(:inspection_number) { |n| "#{ n }" }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    inspection_date { DateTime.now }
    current_value 10500000
    appraiser_value 10000000
    soat_number 'AB98934'
    soat_begin_date '2012-05-29'
    soat_finish_date '2013-05-29'
    emissions_certificate '98798409882'
    emissions_begin_date '2010-02-21'
    emissions_finish_date '2012-02-21'
    maintenance [true, false].sample
    repairs [true, false].sample
    security [true, false].sample
    modifications [true, false].sample
    exterior %w(Bueno Regular Malo).sample
    exterior_notes Faker::Lorem.paragraph 2
    interior %w(Bueno Regular Malo).sample
    interior_notes Faker::Lorem.paragraph 10
    engine %w(Bueno Regular Malo).sample
    engine_notes Faker::Lorem.paragraph 5
    accesories Faker::Lorem.paragraph 10
    insurance_number '123UNOI98'
    insurance_company
    insured_value 15000000
    currency 'COP'
    insurance_start '2013-05-24'
    insurance_finish '2014-05-24'
    observations Faker::Lorem.paragraph 5
    person_in_charge Faker::Name.name
    pic_id '38.766.298'
    pic_job 'Security guard'
    overall_condition "Good"
    inspection_order
  end
end
