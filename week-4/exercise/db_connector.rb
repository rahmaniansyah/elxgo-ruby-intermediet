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