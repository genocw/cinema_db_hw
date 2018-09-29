require("pg")
require_relative("../db/sql_runner.rb")

class Ticket

  attr_accessor :id, :customer_id, :screening_id, :price

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @customer_id = options["customer_id"].to_i
    @screening_id = options["screening_id"].to_i
    @price = options["price"]
  end

  def save()
    sql = "
      INSERT INTO tickets (customer_id, screening_id, price)
      VALUES ($1, $2, $3)
      RETURNING id;
    "
    values = [@customer_id, @screening_id, @price]
    results = SqlRunner.run(sql, values)
    @id = results[0]["id"].to_i
  end

  def self.delete_all()
    sql = "
      DELETE FROM tickets;
    "
    SqlRunner.run(sql)
  end

  def update()
    sql = "
      UPDATE tickets
      SET (customer_id, screening_id, price) = ($1, $2, $3)
      WHERE id = $4
    "
    values = [@customer_id, @screening_id, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customer()
    # know customer id
    sql = "
      SELECT * FROM customers

      INNER JOIN tickets
      ON customers.id = tickets.customer_id

      WHERE customers.id = $1;
    "
    values = [@customer_id]
    results = SqlRunner.run(sql, values)
    return Customer.new(results[0])
    # return customer object
  end

  def film()
    # know film id
    sql = "
      SELECT * FROM films

      INNER JOIN screenings
      ON films.id = screenings.film_id
      INNER JOIN tickets
      ON screenings.id = tickets.screening_id

      WHERE tickets.id = $1
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    return Film.new(results[0])
    # return film object
  end

  def showtime()
    # we know film id
    sql = "
      SELECT showtime FROM screenings

      INNER JOIN tickets
      ON screenings.id = tickets.screening_id

      WHERE tickets.id = $1;
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results[0]["showtime"]
    # return screening time
  end

  # price method?

end
