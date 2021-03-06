require_relative("../db/sql_runner.rb")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  #CREATE one instance
  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values)[0]
    @id = film['id'].to_i()
  end

  #DELETE ALL - class method
  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  #FIND / READ - class method
  def self.all()
    sql = "SELECT * FROM films"
    films_array = SqlRunner.run(sql)
    films = films_array.map { |film_hash| Film.new(film_hash)}
    return films
  end

  #UPDATE one instance
  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  #DELETE one instance
  def delete_one()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #returning all customers at one film
  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1"
    values = [@id]
    customers_array = SqlRunner.run(sql, values)
    customers = customers_array.map { |customer_hash| Customer.new(customer_hash)}
    return customers
  end

  #checking number of customers at one film
  def customers_attending()
    customers_array = customers()
    number_of_customers = customers_array.count
    return "There will be #{number_of_customers} customers at the screening of #{@title}."
  end

end
