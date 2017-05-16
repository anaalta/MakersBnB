ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './data_mapper_setup.rb'
require_relative './models/user'
require 'sinatra/flash'

class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  use Rack::MethodOverride

  get '/' do
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
    $current_user = @user
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
      p $current_user
      erb  :dashboard
  end

  get '/sessions/new' do
    erb :sessions
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    session[:user_id] = user.id
    p params
    p session
    redirect to '/dashboard'

    #flash
  end
=begin
  delete '/dashboard' do
    p $current_user
    p session[:user_id] = nil
    p $current_user
    redirect to '/'
  end

  delete '/users' do
    p $current_user
    p session[:user_id] = nil
    p $current_user
    redirect to '/'
  end
=end

  # get '/home' do
  #   "Welcome, test@example.com" # -- do not leave hard coded!!
  # end

  run! if app_file == $0

end
