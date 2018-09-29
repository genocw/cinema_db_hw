require("pg")
require_relative("../db/sql_runner.rb")
require_relative("ticket.rb")

class Customer

  attr_accessor :id, :name, :funds, :bought

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @funds = options["funds"]
  end

  def save()
    sql = "
      INSERT INTO customers (name, funds)
      VALUES ($1, $2)
      RETURNING id;
    "
    values = [@name, @funds]
    results = SqlRunner.run(sql, values)
    @id = results[0]["id"].to_i
  end

  def self.delete_all()
    sql = "
      DELETE FROM customers;
    "
    SqlRunner.run(sql)
  end

  def update()
    sql = "
      UPDATE customers
      SET (name, funds) = ($1, $2)
      WHERE id = $3
    "
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films()
    # we have customer id
    sql = "
      SELECT * FROM films

      INNER JOIN screenings
      ON films.id = screenings.film_id
      INNER JOIN tickets
      ON screenings.id = tickets.screening_id

      WHERE tickets.customer_id = $1;
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |film_hash| Film.new(film_hash) }
    # return array of film objects
  end

  def buy(film)
    @funds -= film.price
  end

  def how_many_tickets()
    return films.length
  end

end
