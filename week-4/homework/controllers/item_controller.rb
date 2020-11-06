require './models/item.rb'

class ItemController
    def index
        items = Item.get_all_items
        
        ERB.new(File.read("./views/item/index.erb")).result(binding)
    end

    def view_create
        categories = Category.get_all_categories

        ERB.new(File.read("./views/item/create_item.erb")).result(binding)
    end

    def create(params)
        item = Item.new(
            params['name'], params['price'], nil, params['category_id'], params['description']
        )

        new_item = item.save
        
        if new_item
            message = "New Food successfully created!"
            renderer = ERB.new(File.read("./views/success.erb"))
        else
            renderer = ERB.new(File.read("./views/item/index.erb"))
        end
        renderer.result(binding)
    end

    def view_update(id)
        categories = Category.get_all_categories
        item = Item.get_item(id)

        ERB.new(File.read("./views/item/edit_item.erb")).result(binding)
    end

    def update(params)
        # edit_item = Item.update_item(query)
        item = Item.new(
            params['name'], params['price'], params['id'], params['category_id'], params['description']
        )

        item.update

        message = "Successfully update item!"
        ERB.new(File.read("./views/success.erb")).result(binding)
    end

    def show(id)
        item = Item.get_item(id)
        category = Category.get_category(item.first["category_id"]) if !item.first["category_id"].nil?
        
        ERB.new(File.read("./views/item/detail_item.erb")).result(binding)
    end

    def delete(id)
        delete = Item.delete_item(id)
        if delete
            message = "Successfully delete item!"
        else
            message = "Something went wrong!"
        end
        ERB.new(File.read("./views/success.erb")).result(binding)
    end
end