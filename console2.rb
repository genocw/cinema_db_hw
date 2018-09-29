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
  "dob"   =>  "2004-06-06",  # 14
  "funds" =>  500
  })
cust2 = Customer.new({
  "name"  =>  "Fred",
  "dob"   =>  "1995-06-06",  # 23
  "funds" =>  700
  })
cust3 = Customer.new({
  "name"  =>  "Genie",
  "dob"   =>  "2001-06-06",  # 17
  "funds" =>  200
  })

cust1.save()
cust2.save()
cust3.save()

cust3.name = "Aubergine"
cust3.update()

film1 = Film.new({
  "title"   =>  "Watchmen",
  "price"   =>  6.50,
  "age_restriction" =>  18
  })

film2 = Film.new({
  "title"   =>  "Ocean's 8",
  "price"   =>  7.25,
  "age_restriction" =>  nil
  })

film3 = Film.new({
  "title"   =>  "Ray",
  "price"   =>  9.00,
  "age_restriction" =>  16
  })

film1.save()
film2.save()
film3.save()

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

ticket1 = Ticket.new({
  "customer_id"      =>  cust1.id,
  "screening_id"     =>  screening1.id
  })

ticket2 = Ticket.new({
  "customer_id"      =>  cust2.id,
  "screening_id"     =>  screening2.id
  })

ticket3 = Ticket.new({
  "customer_id"      =>  cust3.id,
  "screening_id"     =>  screening3.id
  })

ticket4 = Ticket.new({
  "customer_id"      =>  cust1.id,
  "screening_id"     =>  screening3.id
  })

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()

binding.pry
nil
