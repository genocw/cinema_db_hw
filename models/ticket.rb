require("pg")
require_relative("../db/sql_runner.rb")

class Ticket

  attr_accessor :id, :customer_id, :film_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @customer_id = options["customer_id"].to_i
    @film_id = options["film_id"].to_i
  end

  def save()
    sql = "
      INSERT INTO tickets (customer_id, film_id)
      VALUES ($1, $2)
      RETURNING id;
    "
    values = [@customer_id, @film_id]
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
      SET (customer_id, film_id) = ($1, $2)
      WHERE id = $3
    "
    values = [@customer_id, @film_id, @id]
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

      INNER JOIN tickets
      ON films.id = tickets.film_id

      WHERE films.id = $1
    "
    values = [@film_id]
    results = SqlRunner.run(sql, values)
    return Film.new(results[0])
    # return film object
  end

end
