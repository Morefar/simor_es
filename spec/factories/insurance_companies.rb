require 'faker'

FactoryGirl.define do
  factory :insurance_company do
    name {"#{Faker::Company.name} #{Faker::Company.suffix}"}
    sequence(:nit) { |n| "234.355.2#{n+10}"}
  end
end
