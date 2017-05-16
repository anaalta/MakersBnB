ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './data_mapper_setup.rb'

require_relative './models/user'
require_relative './models/listing'

class MakersBnB < Sinatra::Base
  enable :sessions

  get '/' do
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
    session[:user_id] = user.id
    p params
    p session
    redirect to '/home'
  end

  get '/spaces/new' do
    erb :listings
  end

  post '/spaces' do
    listing = Listing.create(property: params[:property])
    @listings << listing
    erb :confirmation
  end

  get '/home' do
    "Welcome, test@example.com" # -- do not leave hard coded!!
  end

  run! if app_file == $0

end
