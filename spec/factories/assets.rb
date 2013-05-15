FactoryGirl.define do
  factory :asset do
    contract_id {FactoryGirl.build(:contract).id}
    invoice_id
    inventory_number
    license_plate
    make
    model
    year
    cylinder_cap
    color
    service_type
    kind
    body
    fuel_type
    capacity
    motor_number
    rerecorded_motor
    vin
    serial_number
    rerecorded_serial
    chassis_number
    rerecorded_chassis
    mobility_restriction
    shield_level
    horse_power
    importd_assembld
    import_statement
    import_date
    number_of_doors
    property_limitation
    registration_date
    tp_issue_date
    tp_expiration_date
    transit_authority
    book_value
  end
end
