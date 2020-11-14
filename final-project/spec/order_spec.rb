require './models/item.rb'
require './models/order.rb'
require './models/customer.rb'
require './models/order_details.rb'
require './controllers/order_controller.rb'
require './db/mysql_connector.rb'

describe OrderController do
    before(:all) do    
        client = create_db_client    
        
        client.query("SET FOREIGN_KEY_CHECKS = 0;")  
        client.query("TRUNCATE TABLE orders;")  
        client.query("SET FOREIGN_KEY_CHECKS = 1;")

        item = Item.new("Nasi goreng", 10000, 1)
        item.save

        customer = Customer.new("083822323807", 1, "rahma", "rahmaputri13@gmail.com")
        customer.save
    end

    context 'when cart given action' do
        describe '#create' do
            it 'should calculate total_price' do
                @total_price = Order.total_price([10000,10000])

                expect(@total_price).to eq(20000)
            end

            it 'should save to database' do
                order = Order.new(nil, nil, @total_price, 1)
                order.save

                expect(@total_price).to eq(20000)
            end
        end
        
        describe '#delete_all' do
            it 'should delete all cache' do
                OrderDetails.delete_all_cache
    
                expect($redis.keys.empty?).to eq(true)
            end
        end
    end
end