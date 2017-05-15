ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './data_mapper_setup.rb'

class MakersBnB < Sinatra::Base
    enable :sessions

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
