class Item
    attr_accessor :name, :price, :id, :category, :description

    def initialize (name, price, id, category = nil, description)
        @name = name
        @price = price
        @id = id
        @category = category
        @description = description
    
    end
end