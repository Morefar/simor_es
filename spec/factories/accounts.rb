require 'faker'
FactoryGirl.define do
  factory :account do
    organization_name { "#{Faker::Company.name} #{ Faker::Company.suffix }" }
    subdomain { organization_name.parameterize }
  end
end
