FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "contractcategory#{n}" }
  end
end
