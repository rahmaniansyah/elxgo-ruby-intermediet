require './models/item.rb'
require './models/category.rb'
require './models/item_category.rb'

class CategoryController
    
    def index
        categories = Category.all
        renderer = ERB.new(File.read("./views/category/index.erb"))
        renderer.result(binding)     
    end

    def show(id)
        category = Category.find_by_id(id)
        items = ItemCategories.find_items_category_by_id(id)
        ERB.new(File.read("./views/category/detail_category.erb")).result(binding)
    end

    def update(params)
        category = Category.new(params["name"], params["id"], params["item_id"])
        category.update

        message = "Category successfully updated!"
        ERB.new(File.read("./views/success.erb")).result(binding)
    end

    def view_new
        renderer = ERB.new(File.read("./views/category/new_category.erb"))
        renderer.result(binding) 
    end

    def view_edit(id)
        category = Category.find_by_id(id)
        items = Item.all
        selected_items = ItemCategories.find_items_category_by_id(id)

        ERB.new(File.read("./views/category/edit_category.erb")).result(binding)        
    end
    
    def create_category(params)
        category = Category.new(params["name"])
        category.save

        message = "New Category successfully created!"
        renderer = ERB.new(File.read("./views/success.erb"))
        renderer.result(binding)
    end

    def delete(id)
        ItemCategories.delete_by_category_id(id)
        
        category = Category.new(nil, id)
        category.delete

        message = "Successfully delete item!"
        ERB.new(File.read("./views/success.erb")).result(binding)
    end
end