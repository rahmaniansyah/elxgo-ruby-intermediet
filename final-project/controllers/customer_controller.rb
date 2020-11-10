require './models/customer.rb'

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
end