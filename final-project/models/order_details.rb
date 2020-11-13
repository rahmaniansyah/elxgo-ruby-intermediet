require './db/mysql_connector.rb'
require './db/redis.rb'
require './models/item.rb'

class OrderDetails
    attr_accessor :item_id, :quantity, :id, :order_id
    
    def initialize(item_id, quantity, id = nil, order_id = nil)
        @item_id = item_id
        @quantity = quantity
        @id = id
        @order_id = order_id
    end

    def create_cache
        if $redis.get(item_id).nil?
            quantity = @quantity
        else
            data = JSON.parse($redis.get(item_id))
            quantity = @quantity.to_i + data["quantity"].to_i
        end
        
        value = {"item_id": item_id, "quantity": quantity }.to_json
        $redis.set(item_id, value)
    end

    def self.all_cache_orders
        return if $redis.keys.empty?

        items = Array.new
        $redis.keys.each do |key|
            data = JSON.parse($redis.get(key))
            raw_data = Item.find_by_id(data["item_id"]).to_a
            record = raw_data.first unless raw_data.empty?
            price = record["price"] * data["quantity"].to_i
            item = Item.new(record["name"], price, record["id"], nil, data["quantity"].to_i)
            items.push(item)    
        end

        items
    end

    def self.delete_cache(id)
        # puts '--- hei ----' 
        # puts id
        # puts $redis.get(id)
        return if $redis.get(id).nil?
        # puts '--- dadah ----'

        $redis.del(id)
    end

    def self.delete_all_cache
        # puts '--- delete all'
        return if $redis.keys.empty?

        # puts '--- delete all'

        $redis.del($redis.keys)
    end

    def self.save(id, params)
        item = params["item_id"]
        quantity = params["quantity"]
        
        client = create_db_client
        (0..(item.length-1)).each do |i|
            client.query("INSERT INTO order_details (order_id, item_id, quantity) 
                         VALUES (#{id}, #{item[i]}, #{quantity[i]})")
        end

        self.delete_all_cache
    end
end