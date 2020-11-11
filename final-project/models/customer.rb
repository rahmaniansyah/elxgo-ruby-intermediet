require './db/mysql_connector.rb'

class Customer
    attr_accessor :phone, :id, :name, :email

    def initialize(phone, id, name = nil, email = nil)
        @phone = phone
        @name = name
        @email = email
        @id = id        
    end
    
    def self.all
        client = create_db_client
        raw_data = client.query("SELECT * FROM customers")
        customers = Array.new
        raw_data.each do |data|
            customer = Customer.new(data["phone"], data["id"], data["name"], data["email"])
            customers.push(customer)
        end
    
        customers
    end

    def self.find_by_id(id)
        client = create_db_client
        raw_data = client.query("SELECT * FROM customers WHERE id = #{id}")
        customer = raw_data.to_a
    
        customer
    end

    def self.find_by_like(parms)
        client = create_db_client
        raw_data = client.query("SELECT * FROM customers WHERE name LIKE '%#{parms}%' OR phone LIKE '%#{parms}%' OR email LIKE '%#{parms}%' ")
        customers = Array.new
        raw_data.each do |data|
            customer = Customer.new(data["phone"], data["id"], data["name"], data["email"])
            customers.push(customer)
        end
    
        customers
    end

    def save
        return false unless valid?

        client = create_db_client
        client.query("INSERT INTO customers (name, email, phone) VALUES ('#{name}', '#{email}','#{phone}')")
    end

    def update
        return false unless valid?

        client = create_db_client
        client.query("UPDATE customers SET name = '#{name}', phone = '#{phone}', 
            email = '#{email}' WHERE id = #{id} ")
    end

    def delete
        client = create_db_client
        client.query("DELETE FROM customers WHERE id = #{id}")
    end

    def valid?
        return false if @phone.nil?

        return true        
    end
end