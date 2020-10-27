require 'sinatra'
require './db_connector'


# index page show list food
get '/' do
    items = get_all_items
    erb :index, locals: {
        items: items
    }
end

# ---------------------------------
# Route to create new food
get '/new_food' do
    erb :new_food
end

post '/new_food' do
    query = {
        name: params['name'],
        price: params['price'],
        category_id: params['category'],
        description: params['description']
    }

    new_item = create_new_item(query)
    
    if new_item
        return "===== Menu #{params['name']} with price #{params['price']} added! ====="
    else
        redirect '/new_food'
    end
end

get '/success' do
    erb :success
end

