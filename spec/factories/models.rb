# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :model do
    make {FactoryGirl.build(:make)}
    name %w(model1 model2 model3 model4 model5 model6 model7).sample
  end
end
