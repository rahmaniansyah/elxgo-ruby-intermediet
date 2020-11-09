require './db/mysql_connector.rb'

class ItemCategories
    attr_accessor :item_id, :category_id, :id

    def initialize(item_id, category_id, id)
        @item_id = item_id
        @category_id = category_id
        @id = id
    end
    
    def self.find_categories_name_item_by_id(id)
        client = create_db_client
        raw_data = client.query("SELECT GROUP_CONCAT(category SEPARATOR ', ') AS category 
                    FROM item_categories_views WHERE item_id = #{id} GROUP BY name")
        category = raw_data.to_a
        
        category
    end

    def self.find_items_category_by_id(id)
        client = create_db_client
        raw_data = client.query("select * from item_categories_views where category_id = #{id};")
        items = Array.new
        raw_data.each do |data|
            item = Item.new(data["name"], nil, nil, nil)
            items.push(item)
        end

        items
    end

    def self.find_categories_by_id(id)
        client = create_db_client
        raw_data = client.query("SELECT * FROM item_categories_views WHERE item_id = #{id} ORDER BY category_id ASC")
        puts raw_data
        item_categories = Array.new
        raw_data.each do |data|
            item_category = ItemCategories.new(data["item_id"], data["category_id"], data["id"])
            item_categories.push(item_category)
        end

        item_categories
    end
end