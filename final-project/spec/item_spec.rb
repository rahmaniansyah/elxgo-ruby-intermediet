require './models/item.rb'
require './db/mysql_connector.rb'

describe Item do
    before(:all) do    
        client = create_db_client    
        
        client.query("SET FOREIGN_KEY_CHECKS = 0;")  
        client.query("TRUNCATE TABLE items")  
        client.query("SET FOREIGN_KEY_CHECKS = 1;")

        @item = Item.new("Nasi goreng", 10000, 1)
    end

    context "when initialize with valid input" do
        describe '#valid?' do
            it "should return true" do
                item = Item.new("Nasi goreng", 10000, nil)

                expect(item.valid?).to eq(true)
            end
        end
    
        describe '#save' do
            it "should save to database" do
                @item.save
                
                item = Item.find_by_id(1).first
                expect(["Nasi goreng", 10000, 1]).to eq([item['name'], item['price'], item['id']])
            end
        end

        describe '#update' do 
            it "should update item in database" do
                @item.save

                update_record = Item.new("Mie goreng", 13000, 1)
                update_record.update

                record = Item.find_by_id(1).first
                expect(["Mie goreng", 13000, 1]).to eq([record['name'], record['price'], record['id']])
            end
        end

        describe '#delete_by_id(id)' do
            it "should return true" do
                @item.save

                record = Item.delete_by_id(1)

                expect(record).to eq(true)
            end
        end
    end
end