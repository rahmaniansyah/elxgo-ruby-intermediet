require 'mysql2'

def create_db_client
    client = Mysql2::Client.new(
        :host => 'localhost',
        :username => 'root',
        # :password => ENV["DB_PASSWORD"],
        # :database => ENV["DB_NAME"]
        :password => '1305438asep',
        :database => 'food_test_db'
    )
    client
end
