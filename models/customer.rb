require("pg")
require_relative("../db/sql_runner.rb")

class Customer

  attr_accessor :id, :name, :funds

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @funds = options["funds"]
  end

end
