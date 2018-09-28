require("pg")
require_relative("../db/sql_runner.rb")

class Film

  attr_accessor :id, :title, :price

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @price = options["price"].to_f
  end

end
