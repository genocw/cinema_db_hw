require_relative("models/customer.rb")
require_relative("models/film.rb")
require_relative("models/ticket.rb")
require("pry")

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

# ticket1.save()
# ticket2.save()
# ticket3.save()

binding.pry
nil
