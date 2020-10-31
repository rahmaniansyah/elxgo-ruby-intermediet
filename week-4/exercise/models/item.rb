require './db/mysql_connector.rb'

class Item
    attr_accessor :name, :price, :id, :category_id, :description

    def initialize (name, price, id, category_id = nil, description = nil)
        @name = name
        @price = price
        @id = id
        @category_id = category_id
        @description = description
    
    end

    def self.get_all_items
        client = create_db_client
        raw_data = client.query("select * from item")
        items = Array.new
        raw_data.each do |data|
            item = Item.new(data["name"], data["price"], data["id"], data["category_id"], data["description"])
            items.push(item)
        end
    
        items
    end
    
    def self.get_item(id)
        client = create_db_client
        raw_data = client.query("select * from item where id = #{id}")
        item = raw_data.to_a
        
        item
    end

    def self.create_new_item(query)
        client = create_db_client
        last_count_records = client.query("select count(*) as count from item").to_a.first["count"].to_i
        
        client.query("insert into item (name, price, category_id, description) values 
            ('#{query[:name]}','#{query[:price]}','#{query[:category_id]}','#{query[:description]}')")
        
        new_count_records = client.query("select count(*) as count from item").to_a.first["count"].to_i
    
        last_count_records < new_count_records
    end
    
    def self.update_item(query)
        client = create_db_client
        client.query("update item set name = '#{query[:name]}', price = #{query[:price]}, 
                     category_id = #{query[:category_id]}, description = '#{query[:description]}' 
                     where id = #{query[:id]} ")    
    end

    def self.delete_food(id)
        client = create_db_client
        client.query("delete from item where id = #{id}")
    end
end