require 'faker'
FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    sequence(:password) { |n| "F1kjh78#{n}" }
    account_name Faker::Company.name
  end
end
