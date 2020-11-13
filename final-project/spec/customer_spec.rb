require './models/customer.rb'
require './controllers/customer_controller.rb'
require './db/mysql_connector.rb'

describe CustomerController do
    before(:all) do    
        client = create_db_client    
        
        client.query("SET FOREIGN_KEY_CHECKS = 0;")  
        client.query("TRUNCATE TABLE customers")  
        client.query("SET FOREIGN_KEY_CHECKS = 1;")

        @customer = Customer.new("083822323807", 1, "rahma", "rahmaputri13@gmail.com")
        
    end

    context 'when make new customer with valid input' do      
        describe '#valid?' do
            it 'should return true' do
                expect(@customer.valid?).to eq(true)
            end
        end
    
        describe '#save' do
            it 'should save to database' do
                @customer.save
                
                customer = Customer.find_by_id(1).first
                expect("083822323807").to eq(customer["phone"])
            end

        end
    end

    context "when open menu customer" do
        describe '#index' do
            it "should show all customers" do
                customer = Customer.all.first
                
                expect("083822323807").to eq(customer.phone)
            end
        end
    end

    context 'when update customer with valid input' do
        describe '#update' do 
            it "should update customer in database" do
                update_record = Customer.new("083822323111", 1, "rahma", "rahmaputri13@gmail.com")
                update_record.update

                customer = Customer.find_by_id(1).first
                expect("083822323111").to eq(customer['phone'])
            end
        end
    end

    context 'when delete customer' do
        describe '#delete_by_id' do
            it "should return true" do
                expect(@customer.delete).to eq(true)
            end
        end
    end
end