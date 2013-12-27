# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :body do
    sequence(:name) { |n| "Test_Body#{n}" }
  end
end
