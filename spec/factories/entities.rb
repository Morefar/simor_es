require 'faker'
FactoryGirl.define do
  factory :entity do
    address Faker::Address.street_address
    city Faker::Address.city
    email Faker::Internet.email
    sequence (:identification_number) { |n| "289.988.#{n}-5" }
    identification_type { create(:identification_type) }
    mobile_phone Faker::PhoneNumber.cell_phone
    name Faker::Company.name
    phone Faker::PhoneNumber.phone_number
    state Faker::Address.state
  end
end
