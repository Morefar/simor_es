# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :model do
    make {build(:make)}
    name 'model1'
  end
end
