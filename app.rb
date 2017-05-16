ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './data_mapper_setup.rb'

require_relative './models/user'
require_relative './models/listing'

class MakersBnB < Sinatra::Base
  enable :sessions

  get '/' do
    @user=User.new
    @listings = Listing.all
    erb :index
  end

  get '/users/new' do
    erb :new
  end

  post '/users' do
    @user = User.create(email:      params[:email],
                        first_name: params[:first_name],
                        last_name:  params[:last_name],
                        password:   params[:password])
    erb :home
  end

  get '/sessions/new' do
    erb :sessions
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    p session[:user_id] = user.id
    redirect to '/home'
  end

  get '/spaces/new' do
    erb :listings
  end

  post '/spaces' do
    listing = Listing.create(property_name: params[:property_name],
                             description: params[:description],
                             price_per_night: params[:price_per_night])
                             p listing
     @listings = Listing.all
     @listings << listing

    redirect to ('/')
    #erb :confirmation
  end

  get '/home' do
    "Welcome, test@example.com" # -- do not leave hard coded!!
  end

  run! if app_file == $0

  

end
