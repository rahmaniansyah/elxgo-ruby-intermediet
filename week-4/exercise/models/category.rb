require './db/mysql_connector.rb'

class Category
    attr_accessor :name, :id

    def initialize (name, id)
        @name = name
        @id = id
    
    end

    def self.get_category(id)
        client = create_db_client
        raw_data = client.query("select name from categories where id = #{id}")
        category = raw_data.to_a
    
        category
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
end