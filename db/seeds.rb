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

