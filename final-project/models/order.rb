require './db/mysql_connector.rb'

class Order

    attr_accessor :order_date , :id , :total_price, :customer_id
    
    def initialize(order_date , id , total_price, customer_id)
        @order_date = generate_datetime
        @id = id
        @total_price = total_price
        @customer_id = customer_id
    end

    def self.total_price(prices)
        total_price = 0
        prices.each {|price| total_price += price.to_i}
        
        total_price
    end

    def save
        client = create_db_client
        client.query("INSERT INTO orders (order_date, total_price, customer_id) 
                     VALUES ('#{@order_date}', #{@total_price}, #{@customer_id})")
        order_id = created?
        
        order_id
    end
    
    def created?
        client = create_db_client
        result = client.query("SELECT id FROM orders WHERE total_price = #{@total_price} AND customer_id = #{customer_id}")
        result = result.to_a

        id = result.first["id"]
        
        return id
    end


    def generate_datetime
        # YYYY-MM-DD hh:mm:ss
        time = Time.new
        time = time.strftime("%Y-%m-%d %k:%M:%S")

        time
    end
end