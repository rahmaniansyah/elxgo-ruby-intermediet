require 'sinatra'
require 'json'
require './models/item.rb'
require './controllers/item_controller.rb'
require './controllers/category_controller.rb'
require './controllers/customer_controller.rb'
require './controllers/order_controller.rb'
require './controllers/order_details_controller.rb'
require './models/category.rb'

# -------------------------------------
#           ITEM / MENU
# -------------------------------------
$item_controller = ItemController.new
# Route to index page show list food
get '/menu' do
    $item_controller.index(params)
end

# Route to open create new food
get '/menu/new' do
    $item_controller.view_new
end

# Route to update selected food
get '/menu/:id/edit' do
    id = params["id"]
    $item_controller.view_edit(id)
end

# Route to process the selected food
post '/menu/:id/update' do
    $item_controller.update(params)
end

# Route to delete food
get '/menu/:id/delete' do
    id = params["id"]
    $item_controller.delete(id)
end

# Route to open detail food
get '/menu/:id/show' do
    id = params["id"]
    $item_controller.show(id)
end

# Send params to created food
post '/menu/create' do
    $item_controller.create(params)
end

# Send selected item data for cart
post '/menu/add-to-order' do
    order_details_controller = OrderDetailsController.new
    order_details_controller.cache_order(params)
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
$category_controller = CategoryController.new

get '/category' do
    $category_controller.index
end

get '/category/new' do
    $category_controller.view_new
end

get '/category/:id/show' do
    id = params["id"]
    $category_controller.show(id)
end

get '/category/:id/edit' do
    id = params["id"]
    $category_controller.view_edit(id)
end

post '/category/:id/update' do
    id = params["id"]
    $category_controller.update(params)
end

get '/category/:id/delete' do
    id = params["id"]
    $category_controller.delete(id)
end

post '/category/create' do
    $category_controller.create_category(params)
end

# -------------------------------------
#           ORDER
# -------------------------------------
$order_controller = OrderController.new

get '/order' do
    $order_controller.index
end

get '/order/delete-all' do
    $order_controller.delete_all
end

post '/order/create' do
    $order_controller.create(params)
end

# -------------------------------------
#           ORDER DETAILS
# -------------------------------------
$order_details_controller = OrderDetailsController.new

get '/order/:id/delete' do
    id = params["id"]
    $order_details_controller.delete(id)
end

# -------------------------------------
#           CUSTOMER
# -------------------------------------
$customer_controller = CustomerController.new

# view page show all customer list
get '/customer' do
    $customer_controller.index(params)
end

get '/customer/new' do
    $customer_controller.view_new
end

get '/customer/:id/show' do
    id = params["id"]
    $customer_controller.show(id)
end

get '/customer/:id/show/:order_id/order' do
    data = {
        id: params["id"],
        order_id: params["order_id"]
    }
        
    $order_details_controller.show(data)
end

get '/customer/:id/edit' do
    id = params["id"]
    $customer_controller.view_edit(id)
end

post '/customer/:id/update' do
    $customer_controller.update(params)
end

get '/customer/:id/delete' do
    id = params["id"]
    $customer_controller.delete(id)
end

post '/customer/create' do
    $customer_controller.create(params)
end