class Screening

  attr_accessor :id, :showtime, :film_id

  def initialize(options)
    @id       = options["id"] if options["id"]
    @showtime = options["showtime"]
    @film_id  = options["film_id"]
  end

  def save()
    sql = "
      INSERT INTO screenings (showtime, film_id)
      VALUES ($1, $2)
      RETURNING id;
    "
    values = [@showtime, @film_id]
    results = SqlRunner.run(sql, values)
    @id = results[0]["id"].to_i
  end

  # add update method

end
