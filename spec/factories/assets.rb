FactoryGirl.define do
  factory :asset do
    contract_id {FactoryGirl.build(:contract).id}
    invoice_id  Random.rand(1000..5000)
    sequence(:inventory_number) { |n| n }
    license_plate 'CDV797'
    make 'Chevrolet'
    model 'Swift'
    year  (2000..(Date.current >> 12).year)
    cylinder_cap Random.rand(50..7500)
    color %w(blue red white green black orange purpule yellow).sample
    service_type %w(Private Public Diplomatic Official Special Other).sample
    kind %w(car suv motorcycle).sample
    body %w(tank none).sample
    fuel_type %w(Gasoline GNV Diesel GNV-Gasoline Electric Hidrogen Ethanol Biodiesel).sample
    capacity Random.rand(2..5000)
    motor_number '908980985AWDOI345'
    rerecorded_motor false
    sequence(:vin) { |n| "908980985AWDOI34#{n}" }
    sequence(:serial_number) { |n| '9089809#{n}5AWDOI345' }
    rerecorded_serial false
    sequence(:chassis_number) {|n| '9089#{n}0985AWDOI345'}
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
