require './models/item.rb'
require './models/item_category.rb'

class ItemController
    def index(params)
        items = Item.all if params["find"].nil?
        items = Item.find_by_like(params["find"]) unless params["find"].nil?
        
        ERB.new(File.read("./views/item/index.erb")).result(binding)
    end

    def view_new
        categories = Category.all

        ERB.new(File.read("./views/item/new_item.erb")).result(binding)
    end

    def view_edit(id)
        categories = Category.all
        selected_categories = ItemCategories.find_categories_by_id(id)
        item = Item.find_by_id(id)

        ERB.new(File.read("./views/item/edit_item.erb")).result(binding)
    end

    def create(params)
        item = Item.new(
            params['name'], params['price'], nil, params['category_id'], params['description']
        )
        new_item = item.save
        
        message = "New Food successfully created!"
        ERB.new(File.read("./views/success.erb")).result(binding)

    end

    def update(params)
        item = Item.new(
            params['name'], params['price'], params['id'], params['category_id'], params['description']
        )

        item.update
        item.update_categories
        
        message = "Successfully update item!"
        ERB.new(File.read("./views/success.erb")).result(binding)
    end

    def show(id)
        item = Item.find_by_id(id)
        category = ItemCategories.find_categories_name_item_by_id(id)
        
        ERB.new(File.read("./views/item/detail_item.erb")).result(binding)
    end

    def delete(id)
        delete = Item.delete_by_id(id)
        if delete
            message = "Successfully delete item!"
        else
            message = "Something went wrong!"
        end
        ERB.new(File.read("./views/success.erb")).result(binding)
    end
end