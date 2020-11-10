require './models/item.rb'
require './controllers/item_controller.rb'
require './db/mysql_connector.rb'

describe ItemController do
    before(:all) do    
        client = create_db_client    
        
        client.query("SET FOREIGN_KEY_CHECKS = 0;")  
        client.query("TRUNCATE TABLE items")  
        client.query("SET FOREIGN_KEY_CHECKS = 1;")

        @item = Item.new("Nasi goreng", 10000, 1)
    end

    context 'when make new item' do      
        describe '#valid?' do
            it 'should return true' do
                item = Item.new("Nasi goreng", 10000, nil)

                expect(item.valid?).to eq(true)
            end
        end
    
        describe '#save' do
            it 'should save to database' do
                @item.save
                
                item = Item.find_by_id(1).first
                expect(["Nasi goreng", 10000, 1]).to eq([item['name'], item['price'], item['id']])
            end

            # it 'should render correct view' do
            #     controller = ItemController.new
            #     response = controller.view_new

            #     expected_view = ERB.new(File.read("./views/item/new_item.erb"))

            #     expect(response).to eq(expected_view)
            # end
        end
    end

    context "when open page" do
        describe '#index' do
            it "should show all items" do
                item = Item.all.first

                expect(item.name).to eq(@item.name)
            end

            it "should render correct view" do
                items = Item.all
                
                controller = ItemController.new
                response = controller.index

                expected_view = ERB.new(File.read("./views/item/index.erb")).result_with_hash(
                    items: items
                )
                expect(response).to eq(expected_view)
            end
        end
    end

    context 'when update item' do
        describe '#update' do 
            it "should update item in database" do
                update_record = Item.new("Mie goreng", 13000, 1)
                update_record.update

                record = Item.find_by_id(1).first
                expect(["Mie goreng", 13000, 1]).to eq([record['name'], record['price'], record['id']])
            end
        end
    end

    context 'when delete item' do
        describe '#delete_by_id' do
            it "should return true" do
                @item.save

                record = Item.delete_by_id(1)

                expect(record).to eq(true)
            end
        end
    end
end