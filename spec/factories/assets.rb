# ## Schema Information
#
# Table name: `assets`
#
# ### Columns
#
# Name                        | Type               | Attributes
# --------------------------- | ------------------ | ---------------------------
# **`id`**                    | `integer`          | `not null, primary key`
# **`contract_id`**           | `integer`          |
# **`invoice_id`**            | `integer`          |
# **`inventory_number`**      | `string(255)`      |
# **`transit_permit`**        | `string(255)`      |
# **`license_plate`**         | `string(255)`      |
# **`make_id`**               | `integer`          |
# **`model_id`**              | `integer`          |
# **`year`**                  | `integer`          |
# **`cylinder_cap`**          | `integer`          |
# **`color_id`**              | `integer`          |
# **`service_type`**          | `string(255)`      |
# **`kind_id`**               | `integer`          |
# **`body_id`**               | `integer`          |
# **`fuel_type`**             | `string(255)`      |
# **`capacity`**              | `integer`          |
# **`motor_number`**          | `string(255)`      |
# **`rerecorded_motor`**      | `boolean`          |
# **`vin`**                   | `string(255)`      |
# **`serial_number`**         | `string(255)`      |
# **`rerecorded_serial`**     | `boolean`          |
# **`chassis_number`**        | `string(255)`      |
# **`rerecorded_chassis`**    | `boolean`          |
# **`mobility_restriction`**  | `string(255)`      |
# **`shield_level`**          | `integer`          |
# **`horse_power`**           | `string(255)`      |
# **`importd_assembld`**      | `boolean`          |
# **`import_statement`**      | `string(255)`      |
# **`import_date`**           | `string(255)`      |
# **`number_of_doors`**       | `integer`          |
# **`property_limitation`**   | `string(255)`      |
# **`registration_date`**     | `string(255)`      |
# **`tp_issue_date`**         | `string(255)`      |
# **`tp_expiration_date`**    | `string(255)`      |
# **`transit_authority`**     | `string(255)`      |
# **`book_value`**            | `float`            |
# **`inspection_count`**      | `integer`          | `default(0)`
# **`last_inspection_date`**  | `date`             |
# **`created_at`**            | `datetime`         | `not null`
# **`updated_at`**            | `datetime`         | `not null`
#

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
