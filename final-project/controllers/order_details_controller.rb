require 'json'
require './models/order_details.rb'

class OrderDetailsController
    def add_order(params)
        puts '---- params ----'
        puts params
        id = params["id"]
        item_id = params["item_id"]
        price = params["price"]
        order_details = OrderDetails.new(item_id, price, id)
        order_details.create_cache

        return true

        # respond_to {|format| format.json { render result: "success" } }
        # return json ({"result" => "success"})
    end
end