require 'mysql2'
require './item.rb'
require './category.rb'

def create_db_client
    client = Mysql2::Client.new(
        :host => 'localhost',
        :username => 'root',
        :password => '1305438asep',
        :database => 'food_oms_db'
    )
    client
end

def get_all_items
    client = create_db_client
    raw_data = client.query("select * from item")
    items = Array.new
    raw_data.each do |data|
        item = Item.new(data["name"], data["price"], data["id"], data["category_id"], data["description"])
        items.push(item)
    end

    items
end

def get_item(id)
    client = create_db_client
    raw_data = client.query("select * from item where id = #{id}")
    item = raw_data.to_a
    
    item
end

def get_all_categories
    client = create_db_client
    raw_data = client.query("select * from categories")
    categories = Array.new
    raw_data.each do |data|
        category = Category.new(data["name"], data["id"])
        categories.push(category)
    end

    categories
end

def create_new_item(query)
    client = create_db_client
    client.query("insert into item (name, price, category_id, description) values 
                 ('#{query[:name]}','#{query[:price]}','#{query[:category_id]}','#{query[:description]}')")
end

def update_item(query)
    client = create_db_client
    client.query("update item set name = '#{query[:name]}', price = #{query[:price]}, 
                 category_id = #{query[:category_id]}, description = '#{query[:description]}' 
                 where id = #{query[:id]} ")    
end

def delete_food(id)
    client = create_db_client
    client.query("delete from item where id = #{id}")
end