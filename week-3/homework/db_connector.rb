require 'mysql2'

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
end

def create_new_item(name, price)
    client = create_db_client
    client.query("insert into item (name, price) values('#{name}','#{price}')")
end