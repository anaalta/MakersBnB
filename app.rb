ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './data_mapper_setup.rb'
require_relative './models/user'
require_relative './models/listing'
require 'sinatra/flash'

class MakersBnB < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
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
      p session[:user_id]
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
    erb :new_space
  end

  get '/spaces' do
    @user = User.get(session[:user_id])
    erb :spaces
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  post '/spaces' do
    if current_user.nil?
      flash[:errors] = "Log in to list a space."
      redirect '/'
    else
      p @listings = Listing.create(property_name: params[:property_name],
                             description: params[:description],
                             price_per_night: params[:price_per_night])
     p
     p @listings = Listing.all
    redirect '/spaces'
    #erb :confirmation
  end
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
