require './db/mysql_connector.rb'

class Item
    attr_accessor :name, :price, :id, :categories, :description

    def initialize (name, price, id, categories = nil, description = nil)
        @name = name
        @price = price
        @id = id
        @categories = categories
        @description = description
    
    end

    def self.all
        client = create_db_client
        raw_data = client.query("select * from items")
        items = Array.new
        raw_data.each do |data|
            item = Item.new(data["name"], data["price"], data["id"], nil, data["description"])
            items.push(item)
        end
    
        items
    end
    
    def self.find_by_id(id)
        client = create_db_client
        raw_data = client.query("select * from items where id = #{id}")
        item = raw_data.to_a
        
        item
    end

    def self.find_by_like(params)
        client = create_db_client
        raw_data = client.query("SELECT * FROM items WHERE name LIKE '%#{params}%' OR price LIKE '%#{params}%'")
        items = Array.new
        raw_data.each do |data|
            item = Item.new(data["name"], data["price"], data["id"], nil, data["description"])
            items.push(item)
        end
    
        items
    end

    def save
        return false unless valid?
        
        client = create_db_client
        
        client.query("insert into items (name, price, description) values 
        ('#{name}','#{price}','#{description}')")
        
        item_id = is_item_created?

        save_categories(categories, item_id) unless categories.nil?

    end

    def is_item_created?
        client = create_db_client
        result = client.query("SELECT id FROM items WHERE name = '#{@name}' AND price = '#{@price}' AND description = '#{@description}'")
        result = result.to_a
        
        return false if result.empty?

        id = result.first["id"]
        
        return id
    end

    def update_categories
        delete_categories(id)
        save_categories(categories, id) unless categories.nil?
        
    end

    def delete_categories(id)
        client = create_db_client
        client.query("DELETE FROM item_categories WHERE item_id = #{id}")

    end

    def save_categories(categories, item_id)
        client = create_db_client
        categories.each do |category_id|
            client.query("INSERT INTO item_categories (item_id, category_id) VALUES ('#{item_id}', '#{category_id}')")
        end
    end

    def update
        client = create_db_client
        client.query("update items set name = '#{name}', price = '#{price}', 
                     description = '#{description}' where id = #{id} ")
    end

    def get_id
        client = create_db_client
        id = client.query("SELECT name FROM item ORDER BY id DESC LIMIT 1;")
        id = id.first["id"]
    end

    def create_item_categories_record(item_id, category_id)
        client = create_db_client
        record = client.query("insert into itemCategories (item_id, category_id) values 
                ('#{item_id}','#{category_id}')")
    end

    def valid?
        return false if @name.nil?
        return false if @price.nil?

        return true
    end

    def self.delete_by_id(id)
        client = create_db_client
        client.query("delete from items where id = #{id}")

        record = self.find_by_id(id)
        
        record.empty?
    end
end