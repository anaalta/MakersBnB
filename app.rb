ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './data_mapper_setup.rb'

class MakersBnB < Sinatra::Base

    get '/' do
      erb :index
    end

    get '/sessions/new' do

        erb :sessions
    end

  run! if app_file == $0
end
