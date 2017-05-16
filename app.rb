ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './data_mapper_setup.rb'
require_relative './models/user'
require 'sinatra/flash'

class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  get '/users/new' do
    erb :new
  end

  post '/users' do
    @user = User.create(email:      params[:email],
                        first_name: params[:first_name],
                        last_name:  params[:last_name],
                        password:   params[:password], password_confirmation: params[:password_confirmation])

    if @user
      session[:user_id] = @user.id
      erb :home
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :new
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
    p params
    p session
    redirect to '/dashboard'

    #flash
  end

  # get '/home' do
  #   "Welcome, test@example.com" # -- do not leave hard coded!!
  # end

  run! if app_file == $0

end
