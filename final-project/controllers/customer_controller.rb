require './models/customer.rb'
require './db/redis.rb'

class CustomerController
    def index(params)
        customers = Customer.all
        customers = Customer.find_by_like(params["find"]) unless params.nil? || params.empty?
        
        ERB.new(File.read("./views/customer/index.erb")).result(binding)
    end

    def view_new
        ERB.new(File.read("./views/customer/new_customer.erb")).result(binding)
    end

    def create(params)
        customer = Customer.new(params['phone'], nil, params['name'], params['email'])
        customer.save
        
        message = "New customer successfully created!"
        ERB.new(File.read("./views/success.erb")).result(binding)

    end

    def view_edit(id)
        customer = Customer.find_by_id(id)

        ERB.new(File.read("./views/customer/edit_customer.erb")).result(binding)
    end

    def update(params)
        customer = Customer.new(params['phone'], params['id'], params['name'], params['email'])
        customer.update
        
        message = "Successfully update customer!"
        ERB.new(File.read("./views/success.erb")).result(binding)
    end

    def show(id)
        customer = Customer.find_by_id(id)

        ERB.new(File.read("./views/customer/detail_customer.erb")).result(binding)
    end

    def delete(id)
        customer = Customer.new(nil, id)
        customer.delete
        
        message = "Successfully delete item!"
        ERB.new(File.read("./views/success.erb")).result(binding)
    end
end