# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :make do
    sequence(:name) { |n| "Test_Make#{n}" }
  end
end
