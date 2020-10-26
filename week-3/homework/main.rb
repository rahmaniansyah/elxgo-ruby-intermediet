require 'sinatra'
require './db_connector'


# index page show list food
get '/' do
    erb :index
end

# ---------------------------------
# Route to create new food
get '/new_food' do
    erb :new_food
end

post '/new_food' do
    create_new_item( params['name'], params['price'])
    
    unless params['name'].empty? && params['price'].empty?
        return "===== Menu #{params['name']} with price #{params['price']} added! ====="
    else
        redirect '/new_food'
    end
end

get '/success' do
    erb :success
end

