# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :body do
    name %w(Estacas Furgon Cisterna Volco Tolva SRS Cerrada Sedan Estibas Pickup Platon).sample
  end
end
