require("pg")
require_relative("../db/sql_runner.rb")
require_relative("ticket.rb")

class Customer

  attr_accessor :id, :name, :dob, :funds, :student

  def initialize(options)
    @id       = options["id"].to_i if options["id"]
    @name     = options["name"]
    @dob      = options["dob"]
    @funds    = options["funds"].to_f
    @student  = options["student"]
  end

  def save()
    sql = "
      INSERT INTO customers (name, dob, funds)
      VALUES ($1, $2, $3)
      RETURNING id;
    "
    values = [@name, @dob, @funds]
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
      SET (name, dob, funds) = ($1, $2, $3)
      WHERE id = $4
    "
    values = [@name, @dob, @funds, @id]
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

  def age()
    sql = "
      SELECT EXTRACT (YEAR FROM AGE(dob))
      FROM customers
      WHERE id = $1;
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results[0]["date_part"].to_i
    # return current age
  end

  def buy_ticket(screening)
    #
  end

  def how_many_tickets()
    return films.length
  end

  def student?()
    return @student
  end

end
