require_relative("models/customer.rb")
require_relative("models/film.rb")
require_relative("models/ticket.rb")
require("pry")

cust1 = Customer.new({
  "name"  =>  "Bob",
  "funds" =>  500
  })
cust2 = Customer.new({
  "name"  =>  "Sally",
  "funds" =>  700
  })
cust3 = Customer.new({
  "name"  =>  "Genie",
  "funds" =>  200
  })

binding.pry
nil
