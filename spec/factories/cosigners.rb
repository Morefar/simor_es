# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cosigner do
    entity { create(:entity) }
    contract { create(:contract) }
  end
end
