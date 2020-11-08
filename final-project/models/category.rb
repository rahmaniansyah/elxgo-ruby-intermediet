require './db/mysql_connector.rb'

class Category
    attr_accessor :name, :id

    def initialize (name, id = nil, item = nil)
        @name = name
        @id = id
        @items = []
    end

    def self.get_category(id)
        client = create_db_client
        raw_data = client.query("select * from categories where id = #{id}")
        category = raw_data.to_a
    
        category
    end

    def self.get_items_on_category(id)
        client = create_db_client
        raw_data = client.query("select * from itemOnCategories where category_id = #{id};")
        items = Array.new
        raw_data.each do |data|
            item = Item.new(data["name"], nil, nil, nil)
            items.push(item)
        end

        items
    end

    def self.all
        client = create_db_client
        raw_data = client.query("select * from categories")
        categories = Array.new
        raw_data.each do |data|
            category = Category.new(data["name"], data["id"])
            categories.push(category)
        end
    
        categories
    end

    def save
        # return false unless valid?
        client = create_db_client
        client.query("insert into categories (name) values ('#{name}')")
    end

    def update
        client = create_db_client
        client.query("update categories set name = '#{name}' where id = #{id} ")
    end

    def delete
        client = create_db_client
        client.query("delete from categories where id = #{id}")

        # record = self.get_category(id)
        
        # record.empty?
    end

    def valid?
        return false if @name.nil?
    end
end