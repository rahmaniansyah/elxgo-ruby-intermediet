require './db/mysql_connector.rb'
require './db/redis.rb'

class OrderDetails
    attr_accessor :item_id, :price, :id, :order_id
    
    def initialize(item_id, price, id = nil, order_id = nil)
        @item_id = item_id
        @price = price
        @id = id
        @order_id = order_id
    end

    def create_cache
        value = {"item_id": item_id, "price": price }.to_json
        puts '--------'
        puts value
        # $redis.set(id, value)
    end
end