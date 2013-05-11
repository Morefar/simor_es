FactoryGirl.define do
  factory :contract do
    sequence (:client_id) { |n| n }
    sequence (:number) { |n| "10980984-987#{n}"}
    category Category.new(name: 'Financial')
    start_date Date.current
    first_canon_date {start_date >> ([0, 1].sample)}
    duration [6, 12, 24, 48, 60].sample
    periodicity [1, 3, 6, 12].sample
    expiration_date { first_canon_date >> (duration * periodicity)}
    total_value Random.rand(2_000_000.00..500_000_000.00)
    currency %w(COP USD EUR YEN CAN RMB RPE).sample
    location_of_assets %w(Chicago Bogota Medellin Cali Oakland)
  end

end
