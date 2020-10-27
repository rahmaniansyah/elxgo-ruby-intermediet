class Item
    attr_accessor :name, :price, :id, :category_id, :description

    def initialize (name, price, id, category_id = nil, description = nil)
        @name = name
        @price = price
        @id = id
        @category_id = category_id
        @description = description
    
    end
end