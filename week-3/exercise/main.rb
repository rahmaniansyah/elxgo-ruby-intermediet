require 'sinatra'

get '/frank-says' do
    'Put this in your pipe & smoke it'
end

get '/messages' do
    "Hello World"
end

get '/messages/:name' do
    name = params['name']
    "<h1 style =\"background-color:grey\">Hello #{name}!</h1>"
end

get '/messages2/:name' do
    # local/messages/rahma?color=black
    name = params['name']
    color = params['color'] ? params['color'] : 'DodgerBlue'
    erb :message, locals: {
        color: color,
        name: name
    }
end

get '/login' do
    erb :form
end

post '/login' do
    if params['username'] == 'admin' && params['password'] == 'admin'
        return '===== Logged in ====='
    else
        redirect '/login'
    end
end