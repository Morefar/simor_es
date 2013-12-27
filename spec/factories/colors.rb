# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :color do
    sequence(:name) { |n| "color#{n}" }
  end
end
