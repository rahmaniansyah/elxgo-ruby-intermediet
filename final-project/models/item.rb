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
            item = Item.new(data["name"], data["price"], data["id"], data["description"])
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

    def self.find_item_categories_by_id(id)
        client = create_db_client
        raw_data = client.query("select group_concat(category separator ', ') as category from items_categories_views where item_id = #{id} group by name")
        category = raw_data.to_a
        
        category
    end

    def save
        # puts '---  check save validation ----'
        # puts valid?
        return false unless valid?
        
        client = create_db_client
        
        client.query("insert into items (name, price, description) values 
        ('#{name}','#{price}','#{description}')")
        
        item_id = is_item_created?

        save_categories(categories, item_id) unless categories.nil?

    end

    def is_item_created?
        client = create_db_client
        # puts @name
        # puts @price
        # puts @description
        result = client.query("SELECT id FROM items WHERE name = '#{@name}' AND price = '#{@price}' AND description = '#{@description}'")
        result = result.to_a
        
        return false if result.empty?

        id = result.first["id"]
        
        return id
    end

    def save_categories(categories, item_id)
        # puts '-- check categories --'
        # puts categories
        client = create_db_client
        categories.each do |category_id|
            client.query("INSERT INTO item_categories (item_id, category_id) VALUES ('#{item_id}', '#{category_id}')")
        end
    end

    def update
        client = create_db_client
        client.query("update item set name = '#{name}', price = '#{price}', 
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
    # -------------------------------

   def self.update_item(query)
        client = create_db_client
        client.query("update item set name = '#{query[:name]}', price = #{query[:price]}, 
                     category_id = #{query[:category_id]}, description = '#{query[:description]}' 
                     where id = #{query[:id]} ")    
    end

    def self.delete_item(id)
        client = create_db_client
        client.query("delete from item where id = #{id}")

        record = self.get_item(id)
        
        record.empty?
    end
end