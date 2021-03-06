require './models/item.rb'
require './models/category.rb'
require './models/item_category.rb'
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
            it 'should save items to database' do
                @item.save
                
                item = Item.find_by_id(1).first
                expect(["Nasi goreng", 10000, 1]).to eq([item['name'], item['price'], item['id']])
            end

            # it 'should save selected categories' do
            #     category = Category.new("main dish", 2)
            #     category.save
                
            #     Item.save_categories([2], 1)
            #     response = ItemCategories.find_categories_name_item_by_id(1)

            #     expect(response.first["category"]).to eq("main dish")
            # end
        end
    end

    context "when open page" do
        describe '#index' do
            it "should show all items" do
                item = Item.all.first

                expect(item.name).to eq(@item.name)
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

            #     it 'should update selected category' do
            #         update_record = Item.new("Mie goreng", 13000, 1)
            #         update_record.update_categories

            #         record = ItemCategory.find_items_category_by_id(1).first
            #         expect(1).to eq(record["category"])
            #     end
        end

        # describe '#update_categories' do
        #     it 'should update selected category' do
        #         update_record = Item.new("Mie goreng", 13000, 1, [1, 2])
        #         update_record.update_categories

        #         record = ItemCategory.find_items_category_by_id(1).first
        #         expect(1).to eq(record["category"])
        #     end
        # end
    end

    context 'when delete item' do
        describe '#delete_by_id' do
            it "should return true" do
                record = Item.delete_by_id(1)

                expect(record).to eq(true)
            end
        end
    end
end