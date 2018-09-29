require("pg")
require_relative("../db/sql_runner.rb")

class Film

  attr_accessor :id, :title, :price

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @price = options["price"].to_f
  end

  def save()
    sql = "
      INSERT INTO films (title, price)
      VALUES ($1, $2)
      RETURNING id;
    "
    values = [@title, @price]
    results = SqlRunner.run(sql, values)
    @id = results[0]["id"].to_i
  end

  def self.delete_all()
    sql = "
      DELETE FROM films;
    "
    SqlRunner.run(sql)
  end

  def update()
    sql = "
      UPDATE films
      SET (title, price) = ($1, $2)
      WHERE id = $3
    "
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    # we've got film id
    sql = "
      SELECT * FROM customers

      INNER JOIN tickets
      ON customers.id = tickets.customer_id
      INNER JOIN screenings
      ON tickets.screening_id = screenings.id

      WHERE screenings.film_id = $1;
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |customer_hash| Customer.new(customer_hash) }
    # return array of customer objects
  end

  def how_many_customers()
    return customers.length
  end

end
