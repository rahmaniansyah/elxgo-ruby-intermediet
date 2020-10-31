require 'sinatra'
require './db_connector'

# index page show list food
get '/' do
    items = get_all_items
    erb :index, locals: {
        items: items
    }
end

# Route to open create new food
get '/new_food' do
    categories = get_all_categories
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

    new_item = create_new_item(query)
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

    categories = get_all_categories
    item = get_item(id)
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

    edit_item = update_item(query)

    message = "Food successfully updated!"
    redirect "/success?message=#{message}"
end

# Route to delete food
get '/food/:id' do
    id = params["id"]
    delete = delete_food(id)

    redirect '/'
end

# Route to open detail food
get '/detail_food/:id' do
    id = params["id"]

    item = get_item(id)
    category = get_category(item.first["category_id"]) if !item.first["category_id"].nil?
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

