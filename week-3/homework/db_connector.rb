require 'mysql2'
require './item.rb'

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

def create_new_item(query)
    client = create_db_client
    client.query("insert into item (name, price, category_id, description) values 
                 ('#{query[:name]}','#{query[:price]}','#{query[:category_id]}','#{query[:description]}')")
end