require('pry')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')

Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({
  'name' => 'Walter White',
  'funds' => '35'
  })
customer1.save()

customer2 = Customer.new({
  'name' => 'Jesse Pinkman',
  'funds' => '20'
  })
customer2.save()

film1 = Film.new({
  'title' => 'Pulp Fiction',
  'price' => '4'
  })
film1.save()

film2 = Film.new({
  'title' => 'Suspiria',
  'price' => '5'
  })
film2.save()

binding.pry
nil
