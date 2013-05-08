class Dog
    attr_accessor :breed, :age, :name
end

    # def self.breeds
    #     breeds = ['Pincher', 'Snauszer', 'German Shepard', 'Siberian Huskey']
    # end

d = Dog.new
d.name = 'Spot'
puts d.name

puts d.class

d.breed = 'Pincher'
d.age = 4
puts
puts "#{d.name}, I'm a #{d.breed} and I am #{d.age}"
breeds_array = Dog.breeds

breeds_array.each do |breed|
    puts "You can have a #{breed} dog"
end

Dog.find_all
