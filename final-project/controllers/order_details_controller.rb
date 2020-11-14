require 'json'
require './models/order_details.rb'
require './models/customer.rb'

class OrderDetailsController
    def index
        items = OrderDetails.all_cache_orders
        customers = Customer.all

       ERB.new(File.read("./views/order/index.erb")).result(binding)
    end
    
    def cache_order(params)
        item_id = params["item_id"]
        quantity = params["quantity"]
        
        order_details = OrderDetails.new(item_id, quantity)
        order_details.create_cache

        return true
    end

    def delete(id)
        OrderDetails.delete_cache(id)
        items = OrderDetails.all_cache_orders
        customers = Customer.all

        ERB.new(File.read("./views/order/index.erb")).result(binding)
    end
end