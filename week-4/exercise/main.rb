require 'sinatra'
require './models/item.rb'
require './models/category.rb'

# index page show list food
get '/' do
    items = Item.get_all_items
    erb :index, locals: {
        items: items
    }
end

# Route to open create new food
get '/new_food' do
    categories = Category.get_all_categories
    erb :new_food, locals: {
        categories: categories
    }
end

# Route to process the created food
post '/new_food' do
    query = {
        name: params['name'],
        price: params['price'],
        category_id: params['category'],
        description: params['description']
    }

    new_item = Item.create_new_item(query)
    if new_item
        message = "New Food successfully created!"
        redirect "/success?message=#{message}"
    else
        redirect '/new_food'
    end
end

# Route to update selected food
get '/edit_food/:id' do
    id = params["id"]

    categories = Category.get_all_categories
    item = Item.get_item(id)
    erb :edit_food, locals: {
        item: item,
        categories: categories
    }
end

# Route to process the selected food
post '/edit_food' do
    query = {
        id: params['id'],
        name: params['name'],
        price: params['price'],
        category_id: params['category'],
        description: params['description']
    }

    edit_item = Item.update_item(query)

    message = "Food successfully updated!"
    redirect "/success?message=#{message}"
end

# Route to delete food
get '/food/:id' do
    id = params["id"]
    delete = Item.delete_food(id)

    redirect '/'
end

# Route to open detail food
get '/detail_food/:id' do
    id = params["id"]

    item = Item.get_item(id)
    category = Category.get_category(item.first["category_id"]) if !item.first["category_id"].nil?
    erb :detail_food, locals: {
        item: item,
        category: category
    }
end

get '/success' do
    message = params['message'] if !params['message'].nil?

    erb :success, locals: {
        message: message
    }
end

