# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :kind do
    name %w(car truck suv bus minibus motorcycle).sample
  end
end
