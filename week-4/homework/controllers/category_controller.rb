require './models/category.rb'
require './models/item.rb'

class CategoryController
    
    def index
        categories = Category.get_all_categories
        renderer = ERB.new(File.read("./views/category/index.erb"))
        renderer.result(binding)     
    end

    def show(id)
        items = Category.get_items_on_category(id)
        category = Category.get_category(id)
        ERB.new(File.read("./views/category/detail_category.erb")).result(binding)
    end

    def update(params)
        category = Category.new(params["name"], params["id"])
        category.update

        message = "Category successfully updated!"
        ERB.new(File.read("./views/success.erb")).result(binding)
    end

    def assign(id)
        items = Item.get_all_items
        category = Category.get_category(id)
        ERB.new(File.read("./views/category/assign_category.erb")).result(binding)
    end

    def page_create_category
        renderer = ERB.new(File.read("./views/category/create_category.erb"))
        renderer.result(binding) 
    end

    def view_update(id)
        category = Category.get_category(id)

        ERB.new(File.read("./views/category/edit_category.erb")).result(binding)        
    end
    
    def create_category(params)
        category = Category.new(params["name"])
        category.save

        message = "New Category successfully created!"
        renderer = ERB.new(File.read("./views/success.erb"))
        renderer.result(binding)
    end
end