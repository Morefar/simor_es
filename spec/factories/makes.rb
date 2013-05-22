# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :make do
    name %w(Chevrolet Subaru Hyndai Nissan Susuki JingChen).sample
  end
end
