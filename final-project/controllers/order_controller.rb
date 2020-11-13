require 'json'
require './models/order.rb'
require './models/order_details.rb'

class OrderController
    def index
       items = OrderDetails.all_cache_orders

       ERB.new(File.read("./views/order/index.erb")).result(binding)
    end

    def create(params)
        # puts '---- params order ----'
        # puts params
        total_price = Order.total_price(params["price"])
        # puts total_price
        order = Order.new(nil, nil, total_price, params["customer_id"])
        order_id = order.save
        
        OrderDetails.save(order_id, params)

        # message = "New order successfully added!"
        # ERB.new(File.read("./views/success.erb")).result(binding)
    end
end