# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inspection_order do
    contract_url "MyString"
    asset_unique_identifier "MyString"
    recurring false
    renew_period 1
    current_status "MyString"
    notes "MyText"
  end
end
