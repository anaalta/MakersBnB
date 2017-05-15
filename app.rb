ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'

class MakersBnB < Sinatra::Base

    get '/' do

    end


  run! if app_file == $0
end
