ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './data_mapper_setup.rb'

class MakersBnB < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/' do
      @user = User.create(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], password: params[:password])
      erb :home
    end


  run! if app_file == $0
end
