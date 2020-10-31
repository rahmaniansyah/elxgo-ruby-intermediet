require './models/item.rb'

class ItemController
    def create_food(params)
        item = Item.new(
            params['name'], params['price'], params['category_id'], params['description']
        )

        new_item = item.save

        if new_item
            message = "New Food successfully created!"
            renderer = ERB.new(File.read("./views/success.erb"))
        else
            renderer = ERB.new(File.read("./views/index.erb"))
        end
        renderer.result(binding)
    end

    def show_list
        items = Item.get_all_items
        renderer = ERB.new(File.read("./views/index.erb"))
        renderer.result(binding)
    end
end