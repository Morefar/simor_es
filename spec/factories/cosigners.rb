# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cosigner do
    entity {build(:entity)}
    contract {build(:contract)}
  end
end
