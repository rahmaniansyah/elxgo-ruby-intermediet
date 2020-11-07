require '../db/mysql_connector.rb'

class Order

    attr_accessor :reference_no , :customer_name , :date, :items
    
    def initialize(param)
        @reference_no = param[:reference_no ]
        @customer_name = param[:customer_name ]
        @date = param[:date]
    end
end