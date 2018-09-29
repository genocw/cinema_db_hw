require_relative("models/customer.rb")
require_relative("models/film.rb")
require_relative("models/ticket.rb")
require_relative("models/screening.rb")
require("pry")

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

cust1 = Customer.new({
  "name"  =>  "Harvey",
  "funds" =>  500
  })
cust2 = Customer.new({
  "name"  =>  "Fred",
  "funds" =>  700
  })
cust3 = Customer.new({
  "name"  =>  "Genie",
  "funds" =>  200
  })

cust1.save()
cust2.save()
cust3.save()

cust3.name = "Aubergine"
cust3.update()

film1 = Film.new({
  "title"   =>  "Watchmen",
  "price"   =>  6.50
  })

film2 = Film.new({
  "title"   =>  "Ocean's 8",
  "price"   =>  7.25
  })

film3 = Film.new({
  "title"   =>  "Ray",
  "price"   =>  9.00
  })

film1.save()
film2.save()
film3.save()

film3.price = 8.80
film3.update()

ticket1 = Ticket.new({
  "customer_id" =>  cust1.id,
  "film_id"     =>  film1.id
  })

ticket2 = Ticket.new({
  "customer_id" =>  cust2.id,
  "film_id"     =>  film2.id
  })

ticket3 = Ticket.new({
  "customer_id" =>  cust3.id,
  "film_id"     =>  film3.id
  })

ticket4 = Ticket.new({
  "customer_id" =>  cust1.id,
  "film_id"     =>  film3.id
  })

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()

ticket1.film_id = film2.id
ticket2.film_id = film1.id
ticket1.update()
ticket2.update()

cust1.buy(film1)    # cust1 funds balance should be 493.50
cust1.update

screening1 = Screening.new({
  "showtime" => "12:00",
  "film_id"  => film1.id
  })
screening2 = Screening.new({
  "showtime" => "15:00",
  "film_id"  => film2.id
  })
screening3 = Screening.new({
  "showtime" => "18:30",
  "film_id"  => film3.id
  })

screening1.save()
screening2.save()
screening3.save()

binding.pry
nil
