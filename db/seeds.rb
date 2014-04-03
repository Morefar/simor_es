#encoding: UTF-8
require 'rubygems'
require 'factory_girl_rails'

puts "#{Category.count} categories in the system"
puts "#{Color.count} colors in the system"
puts "#{Kind.count} vehicle kinds in the system"
puts "#{Body.count} body types in the system"
puts "#{Make.count} makes in the system"
puts "#{Model.count} models in the system"
puts "#{IdentificationType.count} Identification types created"

Entity.destroy_all
200.times do
  name_array = [Faker::Name.name, "#{Faker::Company.name} #{Faker::Company.suffix}"]
  FactoryGirl.create(:entity, name: name_array.sample, identification_type: IdentificationType.sample)
end
puts "#{Entity.count} entities created"

Contract.destroy_all
100.times do
  FactoryGirl.create(:contract, category: Category.sample, lessee: Entity.sample)
end
puts "#{Contract.count} contracts created"

Cosigner.destroy_all
600.times do
  Cosigner.create(contract: Contract.sample, entity: Entity.sample)
end
puts "#{Cosigner.count} cosigners created"

Asset.destroy_all
letter_array = ('A'..'Z').to_a
digit_array = (0..9).to_a
number_id_array = Array(1..1000)
chassis_postfix = 300
300.times do
  make = Make.sample
  asset = Asset.new(contract: Contract.sample, invoice_id: number_id_array.shuffle!.shift,
                    inventory_number: number_id_array.shuffle!.shift, transit_permit: rand(10_000_000_000..99_999_999_999), cylinder_cap: 3500,
                    service_type: %w(PÚBLICO PRIVADO ESPECIAL DIPLOMATICO).sample, fuel_type: %w(GASOLINA GAS DIESEL BIODIESEL GAS-GASOLINA).sample,
                    capacity: 5, motor_number: "908980985AWDOI#{chassis_postfix}", rerecorded_motor: false, vin: "908NPR985AWDUA#{chassis_postfix}",
                    serial_number: "908980955AWDOI#{chassis_postfix}", rerecorded_serial: false, chassis_number: "908950985AWDOI#{chassis_postfix}",
                    rerecorded_chassis: false, mobility_restriction: 'none', shield_level:  'none', horse_power: 1250,
                    importd_assembld: false, import_statement: '12904AGH9089490', import_date: '2011-04-13',
                    number_of_doors: 5, property_limitation: 'none', registration_date: '2013-02-01', tp_issue_date: '2013-01-01',
                    tp_expiration_date: '2014-02-01', transit_authority: 'SMD Bogota', kind: Kind.sample, body: Body.sample,
                    make: make, model: make.models.sample, color: Color.sample, year: rand(2010..2014),
                    book_value: rand(100000000..500000000.0), license_plate: "#{letter_array.sample}#{letter_array.sample}#{letter_array.sample}#{digit_array.sample}#{digit_array.sample}#{digit_array.sample}")
  chassis_postfix += 1
  if asset.valid?
    asset.save
  end
end

puts "#{Asset.count} Assets created"

InsuranceCompany.destroy_all
50.times do
  FactoryGirl.create(:insurance_company)
end

puts "#{InsuranceCompany.count} Insurance companies created"

Inspection.destroy_all
600.times do
  if Asset.count > 0
    asset = Asset.sample
    FactoryGirl.create(:inspection, asset: asset, insurance_company: InsuranceCompany.sample,
                       current_value: rand(0..asset.book_value), appraiser_value: rand(0..asset.book_value),
                       insured_value: rand(0..asset.book_value), inspection_date: Date.current)
  end
end

puts "#{Inspection.count} Inspections created"

InspectionOrder.destroy_all
300.times do
  FactoryGirl.create(:inspection_order)
end

puts "#{InspectionOrder.count} Inspection orders created."



