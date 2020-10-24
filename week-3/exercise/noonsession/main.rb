require 'sinatra'


get '/list_food' do
    erb :index
end

get '/new_food' do
    erb :new_food
end

get '/success' do
    erb :success
end

post '/new_food' do
    unless params['name'].empty? && params['price'].empty?
        return "===== Menu #{params['name']} with price #{params['price']} added! ====="
    else
        redirect '/new_food'
    end
end
