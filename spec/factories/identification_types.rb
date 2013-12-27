# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identification_type do
    sequence(:name) { |n| "id#{n}test" }
  end
end
