require('pry')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({ 'name' => 'Walter White', 'funds' => '35' })
customer1.save()
customer2 = Customer.new({ 'name' => 'Jesse Pinkman', 'funds' => '20' })
customer2.save()
customer3 = Customer.new({ 'name' => 'Hank Schrader', 'funds' => '42' })
customer3.save()
customer4 = Customer.new({ 'name' => 'Saul Goodman', 'funds' => '61' })
customer4.save()

film1 = Film.new({ 'title' => 'Pulp Fiction', 'price' => '4' })
film1.save()
film2 = Film.new({ 'title' => 'Suspiria', 'price' => '5' })
film2.save()
film3 = Film.new({ 'title' => 'Cloud Atlas', 'price' => '6' })
film3.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id })
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id })
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film2.id })
ticket3.save()
ticket4 = Ticket.new({ 'customer_id' => customer4.id, 'film_id' => film3.id })
ticket4.save()
ticket5 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film3.id })
ticket5.save()
ticket6 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id })
ticket6.save()

# customer2.name = 'Gus Fring'
# customer2.update()
# customer1.delete_one()

# film1.title = 'Reservoir Dogs'
# film1.update()
# film2.delete_one()

customer1.buy_ticket(film1)
customer2.buy_ticket(film2)
customer3.buy_ticket(film2)
customer4.buy_ticket(film3)
customer1.buy_ticket(film3)
customer2.buy_ticket(film1)

customers = Customer.all()
films = Film.all()
tickets = Ticket.all()

binding.pry
nil
