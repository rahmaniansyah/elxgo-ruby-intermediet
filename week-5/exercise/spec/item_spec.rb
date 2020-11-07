require './models/item.rb'
require './db/mysql_connector.rb'

describe Item do
    before(:all) do    
        client = create_db_client    
        
        client.query("SET FOREIGN_KEY_CHECKS = 0;")  
        client.query("TRUNCATE TABLE item")  
        client.query("SET FOREIGN_KEY_CHECKS = 1;")
    end
    
    describe '#valid?' do
        it "should valid" do
            item = Item.new("Nasi goreng", 10000, nil)
    
            valid = item.valid?
    
            expect(valid).to eq(true)
        end
    end

    describe '#save' do
        it "should save to database" do
            item = Item.new("Nasi goreng", 10000, 1)
            res = item.save

            item = Item.get_item(1)
            
            name = item.first["name"].to_s

            expect("Nasi goreng").to eq(name)
        end
    end
end