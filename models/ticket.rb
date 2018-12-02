require_relative('../db/sql_runner.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  #CREATE one instance
  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values)[0]
    @id = ticket['id'].to_i
  end

  #DELETE ALL - class method
  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  #FIND / READ - class method
  def self.all()
    sql = "SELECT * FROM tickets"
    tickets_array = SqlRunner.run(sql)
    tickets = tickets_array.map { |ticket_hash| Ticket.new(ticket_hash)}
    return tickets
  end

  #return film information for a ticket
  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film_hash = SqlRunner.run(sql, values)[0]
    film = Film.new(film_hash)
    return film
  end

  #return customer information for a ticket
  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customer_hash = SqlRunner.run(sql, values)[0]
    customer = Customer.new(customer_hash)
    return customer
  end

end
