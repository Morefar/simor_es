cities = ['Chicago', 'Bogota', 'New York', 'Panama', 'Sidney',
    'Medellin', 'Bucaramanga', 'Cali']


 category_names = [
    {:name => "Financial"},
    {:name => "Importation"},
    {:name => "Real State"},
    {:name => "Infrastructure"},
    {:name => "Operational"},
    {:name => "Multileasing"},
    {:name => "Municipal"},
    {:name => "Leaseback"},
  ]

  vehicles = ['Mazda', 'Reanult', 'Kia', 'Hyundai', 'Chevrolet', ]

Category.destroy_all
category_names.each do |cat|
  c = Category.new
  c.name = cat[:name]
  c.save
end

puts "#{Category.count} categories created"

 Contract.destroy_all
 random = Random.new
 15.times do
  c = Contract.new

  c.number = "#{random.rand(1000000..2000000)}-#{random.rand(100..999)}"
  c.category = Category.find_by_id(random.rand(Category.first.id..Category.last.id))
  c.start_date = Date.parse("#{random.rand(2008..2013)}-#{random.rand(1..12)}-#{1..30}")
  c.month_duration = random.rand(12..60)
  c.expiration_date = c.start_date >> c.month_duration
  c.total_value = random.rand(1000000.0..1000000000.0)
  c.asset_count = random.rand(1..20)
  c.location_of_assets = cities.sample
  c.option_to_buy = random.rand(1..2).odd?
  (c.last_date_to_option = c.start_date >> (c.month_duration - 6)) if c.option_to_buy

  c.save
 end
contract_array = Contract.count
puts "#{contract_array.size} contracts created"
random = Random.new
inventory_numbers = (500..5000).to_a
invoice_number = random(2000..5000)

contract_array.each do |contract|
  remaining_value = contract.total_value
  contract.asset_count.times do |asset|
    asset.inventory_number = inventory_numbers.sample
    asset.invoice_number = random(2000..5000)
    asset.value = random(0.0..remaning_value)
    remaining_value -= asset.value
    asset.invoice_date = contract.start_date << (random(-5..0))

    asset.save
  end
end





