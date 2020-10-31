require './models/category.rb'

class CategoryController
    
    def index
        categories = Category.get_all_categories
        renderer = ERB.new(File.read("./views/category_view.erb"))
        renderer.result(binding)     
    end

    def page_create_category
        renderer = ERB.new(File.read("./views/new_category.erb"))
        renderer.result(binding) 
    end
    
    def create_category(params)
        category = Category.new(params["name"])
        category.save

        message = "New Food successfully created!"
        renderer = ERB.new(File.read("./views/success.erb"))
        renderer.result(binding)
    end
end