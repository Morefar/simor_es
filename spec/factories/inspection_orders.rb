# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :inspection_order do
    contract_url "https://www.example.com/contracts/"
    asset_unique_identifier 'CDV130'
    recurring true
    renew_period 6
    current_status %w(OPEN ASSIGNED PENDING CLOSED).sample
    notes Faker::Lorem.paragraph 20
  end
end
