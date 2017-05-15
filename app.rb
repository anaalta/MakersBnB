ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './data_mapper_setup.rb'

require_relative './models/user'

class MakersBnB < Sinatra::Base
    enable :sessions


  get '/' do
      erb :index
    end
  
  post '/home' do
      @user = User.create(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], password: params[:password])
      erb :home
    end
  
  
 post'/sessions' do
   erb :index
 end 
    
    get '/sessions/new' do
        user = User.authenticate(params[:email], params[:password])
        session[:user_id] = user.id
        erb :sessions
    end


  run! if app_file == $0
end