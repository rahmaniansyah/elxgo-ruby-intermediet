require 'json'
require './models/order.rb'
require './models/order_details.rb'

class OrderController
    def index
       items = OrderDetails.all_cache_orders

       ERB.new(File.read("./views/order/index.erb")).result(binding)
    end
end