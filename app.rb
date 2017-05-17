ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './data_mapper_setup.rb'
require_relative './models/user'
require_relative './models/listing'
require 'sinatra/flash'

class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  use Rack::MethodOverride

  get '/' do
    @user=User.new
    @listings = Listing.all
    erb :index
  end

  get '/users/new' do
    @user = User.new
    erb :new
  end

  post '/users' do
    @user = User.create(email:  params[:email],
                    first_name: params[:first_name],
                    last_name:  params[:last_name],
                    password:   params[:password], password_confirmation: params[:password_confirmation])

    if @user.save
      session[:user_id] = @user.id
      p @user.id
      erb :users
    else
      flash.now[:errors] = @user.errors.full_messages
      redirect to '/users/new'
    end
  end

  get '/dashboard' do
    erb  :dashboard
  end

  get '/sessions/new' do
    erb :sessions
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    session[:user_id] = user.id
    redirect to '/dashboard'
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
  end

  delete '/dashboard' do
    session[:user_id] = nil
    redirect to '/'
  end

  delete '/users' do
    p session[:user_id] = nil
    redirect to '/'
  end

  run! if app_file == $0
end
