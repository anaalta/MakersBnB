ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './data_mapper_setup.rb'

class MakersBnB < Sinatra::Base

    get '/' do
      "Welcome to MakersBNB!"
    end


  run! if app_file == $0
end
