require_relative('../db/sql_runner.rb')
# require_relative('')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  #CREATE one instance
  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0]
    @id = customer['id'].to_i()
  end

  #DELETE ALL - class method
  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  #FIND / READ - class method
  def self.all()
    sql = "SELECT * FROM customers"
    customers_array = SqlRunner.run(sql)
    customers = customers_array.map { |customer_hash| Customer.new(customer_hash)}
    return customers
  end

  #UPDATE one instance
  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  #DELETE one instance
  def delete_one()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #returning all films for one customer
  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    films_array = SqlRunner.run(sql, values)
    films = films_array.map { |film_hash| Film.new(film_hash)}
    return films
  end

end
