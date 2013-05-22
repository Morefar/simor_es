# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :build do
    kind {FactoryGirl.build(:kind)}
    body {FactoryGirl.build(:body)}
  end
end
