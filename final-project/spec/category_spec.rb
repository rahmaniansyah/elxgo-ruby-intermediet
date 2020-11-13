require './models/category.rb'
require './models/item_category.rb'
require './controllers/category_controller.rb'
require './db/mysql_connector.rb'

describe CategoryController do
    before(:all) do    
        client = create_db_client    
        
        client.query("SET FOREIGN_KEY_CHECKS = 0;")  
        client.query("TRUNCATE TABLE categories")  
        client.query("SET FOREIGN_KEY_CHECKS = 1;")

        @category = Category.new("Main dish", 1)
    end

    context 'when make new category with valid input' do      
        describe '#valid?' do
            it 'should return true' do
                expect(@category.valid?).to eq(true)
            end
        end
    
        describe '#save' do
            it 'should save to database' do
                @category.save
                
                category = Category.find_by_id(1).first
                expect("Main dish").to eq(category["name"])
            end

        end
    end

    context "when open menu category" do
        describe '#index' do
            it "should show all items" do
                category = Category.all.first
                
                expect("Main dish").to eq(category.name)
            end
        end
    end

    context 'when update category with valid input' do
        describe '#update' do 
            it "should update category in database" do
                update_record = Category.new("Signature", 1)
                update_record.update

                category = Category.find_by_id(1).first
                expect("Signature").to eq(category['name'])
            end
        end
    end

    context 'when delete category' do
        describe '#delete_by_id' do
            it "should return true" do
                expect(@category.delete).to eq(true)
            end
        end
    end
end