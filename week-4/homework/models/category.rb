require './db/mysql_connector.rb'

class Category
    attr_accessor :name, :id

    def initialize (name, id = nil)
        @name = name
        @id = id
    
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

    def self.get_all_categories
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
        puts '---------'
        puts name
        puts '---------'
        client = create_db_client
        client.query("insert into categories (name) values ('#{name}')")
    end

    def valid?
        return false if @name.nil?
    end
end