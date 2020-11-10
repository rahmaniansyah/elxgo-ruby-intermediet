require 'sinatra'
require './models/item.rb'
require './controllers/item_controller.rb'
require './controllers/category_controller.rb'
require './controllers/customer_controller.rb'
require './models/category.rb'

# -------------------------------------
#           ITEM / MENU
# -------------------------------------

# index page show list food
get '/menu' do
    item_controller = ItemController.new
    item_controller.index(params)
end

# index page show list food with filter
# get '/menu/:find' do
#     item_controller = ItemController.new
#     item_controller.index(params)
# end

# Route to open create new food
get '/menu/new' do
    item_controller = ItemController.new
    item_controller.view_new
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
    item_controller.view_edit(id)
end

# Route to process the selected food
post '/menu/:id/update' do
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

# -------------------------------------
#           CATEGORY
# -------------------------------------

get '/category' do
    controller = CategoryController.new
    controller.index
end

get '/category/new' do
    controller = CategoryController.new
    controller.view_new
end

get '/category/:id/show' do
    id = params["id"]
    controller = CategoryController.new
    controller.show(id)
end

get '/category/:id/edit' do
    id = params["id"]
    controller = CategoryController.new
    controller.view_edit(id)
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

post '/category/create' do
    controller = CategoryController.new
    controller.create_category(params)
end

# -------------------------------------
#           CUSTOMER
# -------------------------------------


$customer_controller = CustomerController.new
# view page show all customer list
get '/customer' do
    $customer_controller.index(params)
end

# view page show all customer list with filter
# get '/customer/:find' do
#     $customer_controller.index(params)
# end

get '/customer/new' do
    $customer_controller.view_new
end

# get '/customer/:id/show' do
#     id = params["id"]
#     $customer_controller.show(id)
# end

get '/customer/:id/edit' do
    id = params["id"]
    $customer_controller.view_edit(id)
end

post '/customer/:id/update' do
    $customer_controller.update(params)
end

# get '/customer/:id/delete' do
#     id = params["id"]
#     controller = CategoryController.new
#     controller.delete(id)
# end

post '/customer/create' do
    $customer_controller.create(params)
end

