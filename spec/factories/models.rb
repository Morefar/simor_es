# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :model do
    make
    sequence(:name) { |n| "Test_Model#{n}" }
  end
end
