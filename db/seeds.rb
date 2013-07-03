require 'rubygems'
require 'factory_girl_rails'

cities = ['Chicago', 'Bogota', 'New York', 'Panama', 'Sidney',
    'Medellin', 'Bucaramanga', 'Cali']


 category_names = [
    "Financial",
    "Importation",
    "Real State",
    "Infrastructure",
    "Operational",
    "Multileasing",
    "Municipal",
    "Leaseback",
  ]

Category.destroy_all
category_names.each do |cat|
  FactoryGirl.create(:category, name: cat)
end
puts "#{Category.count} categories created"

color_names = ['White', 'Green', 'Blue', 'Yellow', 'Red', 'Black', 'Orange',
            'purple', 'pink', 'gray', 'metallic black']
Color.destroy_all
color_names.each do |c|
  FactoryGirl.create(:color, name: c)
end
puts "#{Color.count} colors created"
kind_names = ['Car', 'Truck', 'SUV', 'Utility Vehicle', 'Bus', 'Microbus']
body_names = ['Pickup', 'Camper', 'Surrey', 'Van', 'Coach']
Kind.destroy_all
Body.destroy_all
kind_names.each do |c|
  FactoryGirl.create(:kind, name: c)
end
puts "#{Kind.count} vehicle kinds created"
body_names.each do |c|
  FactoryGirl.create(:body, name: c)
end
puts "#{Body.count} body types created"
Build.destroy_all
FactoryGirl.create(:build,
  kind: Kind.find_by_name('Truck'),
  body: Body.find_by_name('Camper'))
FactoryGirl.create(:build,
  kind: Kind.find_by_name('SUV'),
  body: Body.find_by_name('Pickup'))
FactoryGirl.create(:build,
  kind: Kind.find_by_name('Truck'),
  body: Body.find_by_name('Coach'))
FactoryGirl.create(:build,
  kind: Kind.find_by_name('Bus'),
  body: Body.find_by_name('Coach'))
FactoryGirl.create(:build,
  kind: Kind.find_by_name('Utility Vehicle'),
  body: Body.find_by_name('Camper'))
FactoryGirl.create(:build,
  kind: Kind.find_by_name('Microbus'),
  body: Body.find_by_name('Coach'))
puts "#{Build.count} build configurations created"
make_names = ['Chevrolet', 'Renault', 'Kia', 'Mazda', 'Hyundai', 'Fiat']
Make.destroy_all
Model.destroy_all
make_names.each do |c|
  FactoryGirl.create(:make, name: c)
end
puts "#{Make.count} makes created"
make_model_hash = {
  'Chevrolet' => ['TAXI 7:24', '454 SS', 'ALTO', 'APACHE', 'ASTRA', 'AVEO'],
  'Renault' => ['11 GTL', 'CITIUS', 'CLIO', 'CLIO AUTENTIQUE', 'CLIO AUTENTIQUE COOL', 'CLIO COOL'],
  'Kia' => ['2700', '3500', '3600', '3500 S', '3600 S', 'BESTA'],
  'Mazda' => ['626', '929', '121 LX', '323 ASTINA', '323 DX PROTECT', '323 EL LINCE'],
  'Hyundai' => ['300', 'A 418 GLS', 'AC 500 1 LS', 'ACCENT', 'ACCENT 4D', 'ACCENT 4D GLS'],
  'Fiat' => ['125', '145', '850', '1100', '2100', '2200']
}
makers_array = Make.all.to_a
makers_array.each do |maker|
    make_model_hash[maker.name].each do |model|
      FactoryGirl.create(:model, make: maker, name: model)
    end
end
puts "#{Model.count} models created"

IdentificationType.destroy_all
id_type_array = %w(CC NIT CE PASSPORT OTHER)
id_type_array.each do |type_name|
  FactoryGirl.create(:identification_type, name: type_name)
end
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

Asset.destroy_all
letter_array = ('A'..'Z').to_a
digit_array = (0..9).to_a
number_id_array = Array(1..1000)
300.times do
  build = Build.sample
  a = Asset.new(contract: Contract.sample, invoice_id: number_id_array.shuffle!.shift, inventory_number: number_id_array.shuffle!.shift, cylinder_cap: 3500, service_type: %w(PUBLIC PRIVATE ESPECIAL DIPLOMATIC).sample, fuel_type: %w(GASOLINE GAS DIESEL BIODIESEL GAS-GASOLINE).sample, capacity: 5, motor_number: '908980985AWDOI345', rerecorded_motor: false, vin: "908NPR985AWDUA342", serial_number: "908980955AWDOI345", rerecorded_serial: false, chassis_number: "908950985AWDOI345", rerecorded_chassis: false, mobility_restriction: 'none', shield_level:  'none', horse_power: 1250, importd_assembld: false, import_statement: '12904AGH9089490', import_date: '2011-04-13', number_of_doors: 5, property_limitation: 'none', registration_date: '2013-02-01', tp_issue_date: '2013-01-01', tp_expiration_date: '2014-02-01', transit_authority: 'SMD Bogota', kind: build.kind, body: build.body, make: Make.sample, model: Model.sample, color: Color.sample, year: rand(2010..2014), book_value: rand(100000000..500000000.0), license_plate: "#{letter_array.sample}#{letter_array.sample}#{letter_array.sample}#{digit_array.sample}#{digit_array.sample}#{digit_array.sample}")
  a.save
end

puts "#{Asset.count} Assets created"

InsuranceCompany.destroy_all
50.times do
  FactoryGirl.create(:insurance_company)
end

puts "#{InsuranceCompany.count} Insurance companies created"

Inspection.destroy_all
600.times do
  asset = Asset.sample
  FactoryGirl.create(:inspection, asset: asset, insurance_company: InsuranceCompany.sample, current_value: rand(0..asset.book_value), appraiser_value: rand(0..asset.book_value), insured_value: rand(0..asset.book_value),
    date: Time.now)
end

puts "#{Inspection.count} Inspections created"

InspectionOrder.destroy_all
300.times do
  FactoryGirl.create(:inspection_order)
end

puts "#{InspectionOrder.count} Inspection orders created."



