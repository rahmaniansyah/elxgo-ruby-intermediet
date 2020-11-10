require './models/customer.rb'

class CustomerController
    def index(params)
        puts '------'
        puts params.nil?
        puts params.empty?
        customers = Customer.all if params.nil?
        customers = Customer.find_by_like(params["find"]) unless params.nil? || params.empty?
        
        ERB.new(File.read("./views/customer/index.erb")).result(binding)
    end
end