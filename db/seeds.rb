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

puts "15 contracts created"



