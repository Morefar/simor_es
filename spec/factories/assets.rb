FactoryGirl.define do
  factory :asset do
    contract {FactoryGirl.build(:contract)}
    invoice_id Random.rand(1000..5000)
    sequence(:inventory_number) { |n| n }
    license_plate 'CDV797'
    make {FactoryGirl.build(:make)}
    model {FactoryGirl.build(:model, make: make)}
    year  Random.rand(2000..(Date.current >> 12).year)
    cylinder_cap Random.rand(50..7500)
    color {FactoryGirl.build(:color)}
    service_type %w(Private Public Diplomatic Official Special Other).sample
    kind {FactoryGirl.build(:kind)}
    body {FactoryGirl.build(:body)}
    fuel_type %w(Gasoline GNV Diesel GNV-Gasoline Electric Hidrogen Ethanol Biodiesel).sample
    capacity Random.rand(2..3500)
    motor_number '908980985AWDOI345'
    rerecorded_motor false
    sequence(:vin) { |n| "908NPR985AWDUA342" }
    sequence(:serial_number) { |n| "908980955AWDOI345" }
    rerecorded_serial false
    sequence(:chassis_number) {|n| "908950985AWDOI345"}
    rerecorded_chassis false
    mobility_restriction 'none'
    shield_level  'none'
    horse_power Random.rand(300..9000)
    importd_assembld false
    import_statement '12904AGH9089490'
    import_date '2011-04-13'
    number_of_doors 5
    property_limitation 'none'
    registration_date Date.current.to_s
    tp_issue_date Date.current.to_s
    tp_expiration_date Date.current.to_s
    transit_authority 'SMD Bogota'
    book_value '12000000'
  end
end
