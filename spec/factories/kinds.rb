# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :kind do
    sequence(:name) { |n| "test_kind#{n}" }
  end
end
