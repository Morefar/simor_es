# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :color do
    name %w(white black blue yellow pink red green gray purpule).sample
  end
end
