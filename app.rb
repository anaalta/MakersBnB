ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './data_mapper_setup.rb'

require_relative './models/user'

class MakersBnB < Sinatra::Base
    enable :sessions


  get '/' do
      erb :index
    end

  post '/users/new' do
      @user = User.create(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], password: params[:password])
      erb :home
  end

 get '/sessions/new' do
   erb :sessions
 end

post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    p params
    session[:user_id] = @user.id
    redirect to  '/home'
end


  run! if app_file == $0
end
