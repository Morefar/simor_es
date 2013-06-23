FactoryGirl.define do
  factory :asset do
    before(:create) do |asset|
    create(:build, kind: asset.kind, body: asset.body)
    end
    contract
    invoice_id 12
    sequence(:inventory_number) { |n| n }
    license_plate 'ABC197'
    make { build(:make) }
    model {build(:model, make: make)}
    year  2013
    cylinder_cap 3500
    color {build(:color)}
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
