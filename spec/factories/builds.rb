# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :build do
    kind {create(:kind)}
    body {create(:body)}
  end
end
