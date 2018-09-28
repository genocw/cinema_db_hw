require("pg")
require_relative("../db/sql_runner.rb")

class Customer

  attr_accessor :id, :name, :funds

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

end
