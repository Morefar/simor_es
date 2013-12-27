FactoryGirl.define do
  factory :asset do
    contract
    invoice_id 12
    make
    model { create(:model, make: make) }
    sequence(:inventory_number) { |n| n }
    license_plate 'ABC197'
    transit_permit '79379879845'
    year  2013
    cylinder_cap 3500
    color
    service_type "private"
    kind
    body
    fuel_type 'Gasoline'
    capacity 5
    motor_number '908980985AWDOI345'
    rerecorded_motor false
    vin "908NPR985AWDUA342"
    serial_number "908980955AWDOI345"
    rerecorded_serial false
    chassis_number "908950985AWDOI345"
    rerecorded_chassis false
    mobility_restriction 'none'
    shield_level  'none'
    horse_power 1250
    importd_assembld false
    import_statement '12904AGH9089490'
    import_date '2011-04-13'
    number_of_doors 5
    property_limitation 'none'
    registration_date '2013-02-01'
    tp_issue_date '2013-01-01'
    tp_expiration_date '2014-02-01'
    transit_authority 'SMD Bogota'
    book_value '12000000'
  end
end
