require './models/item.rb'
require './models/order_details.rb'
require './controllers/order_details_controller.rb'
require './db/mysql_connector.rb'

describe OrderDetailsController do
    before(:all) do    
        client = create_db_client    
        
        client.query("SET FOREIGN_KEY_CHECKS = 0;")  
        client.query("TRUNCATE TABLE order_details;")  
        client.query("SET FOREIGN_KEY_CHECKS = 1;")

        item = Item.new("Nasi goreng", 10000, 1)
        item.save
    end

    context 'when add item to cart' do      
        describe '#chace_order' do
            it 'should save selected item to cahce memory' do
                order_details = OrderDetails.new(1, 1)
                order_details.create_cache

                order_detail = JSON.parse($redis.get(1))


                expect(order_detail["item_id"]).to eq(1)
            end
        end
    end

    context 'when cart given action' do
        describe '#create' do
            it 'should add to database' do
                
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