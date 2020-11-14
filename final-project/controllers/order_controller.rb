require 'json'
require './models/order.rb'
require './models/order_details.rb'
require './models/customer.rb'

class OrderController
    # def index
    #    items = OrderDetails.all_cache_orders

    #    ERB.new(File.read("./views/order/index.erb")).result(binding)
    # end

    def index
        items = OrderDetails.all_cache_orders
        customers = Customer.all

       ERB.new(File.read("./views/order/index.erb")).result(binding)
    end

    def create(params)
        total_price = Order.total_price(params["price"])
        order = Order.new(nil, nil, total_price, params["customer_id"])
        order_id = order.save
        
        OrderDetails.save(order_id, params)

        message = "New order successfully added!"
        ERB.new(File.read("./views/success.erb")).result(binding)
    end

    def delete_all
        puts '--- delete'
        OrderDetails.delete_all_cache
        items = OrderDetails.all_cache_orders
        
        ERB.new(File.read("./views/order/index.erb")).result(binding)
    end
end