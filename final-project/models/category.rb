require './db/mysql_connector.rb'

class Category
    attr_accessor :name, :id

    def initialize (name, id = nil, item = nil)
        @name = name
        @id = id
        @items = item
    end

    def self.find_by_id(id)
        client = create_db_client
        raw_data = client.query("select * from categories where id = #{id}")
        category = raw_data.to_a
    
        category
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
        
        client.query("DELETE FROM item_categories WHERE category_id = #{id}")
        save_categories unless @items.nil?
    end

    def save_categories
        client = create_db_client
        @items.each do |item|
            client.query("INSERT INTO item_categories (item_id, category_id) VALUES ('#{item}', '#{@id}')")
        end
    end

    def delete
        client = create_db_client
        client.query("delete from categories where id = #{id}")
        client.query("DELETE FROM item_categories WHERE category_id = #{id}")

        # record = self.get_category(id)
        
        # record.empty?
    end

    def valid?
        return false if @name.nil?
    end
end