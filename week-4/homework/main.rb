require 'sinatra'
require './models/item.rb'
require './controllers/item_controller.rb'
require './controllers/category_controller.rb'
require './models/category.rb'

# index page show list food
get '/menu' do
    item_controller = ItemController.new
    item_controller.index
end

# Route to open create new food
get '/menu/create' do
    item_controller = ItemController.new
    item_controller.view_create
end

# Route to process the created food
post '/menu/create' do
    item_controller = ItemController.new
    item_controller.create(params)
end

# Route to update selected food
get '/menu/:id/edit' do
    id = params["id"]
    item_controller = ItemController.new
    item_controller.view_update(id)
end

# Route to process the selected food
post '/update' do
    item_controller = ItemController.new
    item_controller.update(params)
end

# Route to delete food
get '/menu/:id/delete' do
    id = params["id"]
    item_controller = ItemController.new
    item_controller.delete(id)
    # 

    # redirect '/menu'
end

# Route to open detail food
get '/menu/:id/show' do
    id = params["id"]
    item_controller = ItemController.new
    item_controller.show(id)
end

get '/success' do
    message = params['message'] if !params['message'].nil?

    erb :success, locals: {
        message: message
    }
end

get '/category' do
    controller = CategoryController.new
    controller.index
end

get '/category/:id/show' do
    id = params["id"]
    controller = CategoryController.new
    controller.show(id)
end

get '/category/:id/assign' do
    id = params["id"]
    controller = CategoryController.new
    controller.assign(id)
end

get '/category/:id/edit' do
    id = params["id"]
    controller = CategoryController.new
    controller.view_update(id)
end

post '/category/:id/update' do
    id = params["id"]
    controller = CategoryController.new
    controller.update(params)
end

get '/category/:id/delete' do
    id = params["id"]
    controller = CategoryController.new
    controller.delete(id)
end

get '/new-category' do
    controller = CategoryController.new
    controller.page_create_category
end

post '/add-category' do
    controller = CategoryController.new
    controller.create_category(params)
end

