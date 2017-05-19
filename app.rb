ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './data_mapper_setup.rb'
require_relative './models/user'
require_relative './models/listing'
require_relative './models/booking'
require 'sinatra/flash'
require 'stripe'

class MakersBnB < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash
  use Rack::MethodOverride
  set :publishable_key, ENV['PUBLISHABLE_KEY']
  set :secret_key, ENV['SECRET_KEY']
  Stripe.api_key = settings.secret_key

  get '/' do
    current_user
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
      erb :users
    else
      flash.now[:errors] = @user.errors.full_messages
      redirect to '/users/new'
    end
  end

  get '/dashboard' do
    @listings = Listing.all
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
    current_user
    erb :new_space
  end

  get '/spaces' do
    @listings = Listing.all
    current_user
    redirect to ('/dashboard')
  end

  post '/spaces' do
    if current_user.nil?
      flash[:errors] = "Log in to list a space."
      redirect '/'
    else
      listing = Listing.create(property_name: params[:property_name],
                             description: params[:description],
                             price_per_night: params[:price_per_night],
                             available_from: params[:available_from],
                             available_until: params[:available_until],
                             user_id: session[:user_id])
     @listings = Listing.all
     @listings << listing
    redirect '/dashboard'
  end
  end

  get '/booking/new' do
    @listing = Listing.get(params[:property_id])
    session[:property_id] = params[:property_id]
    erb :new_booking
  end

  post "/booking" do
    p @listing =Listing.get(session[:property_id])
    p @booking = Booking.create(start_date: params[:start_date],
                                end_date: params[:end_date],
                                listing_id: session[:property_id],
                                user_id: session[:user_id])
    @bookings = Booking.all
    #@booking.total_price = ((@booking.end_date - @booking.start_date-1)*@listing.price_per_night).to_f
    @bookings << @booking
    if @booking.start_date < @listing.available_from
    flash.now[:notice1] = "Start date is not available"
  elsif @booking.end_date > @listing.available_until
    flash.now[:notice2] = "End date is not available"
     else
      erb :booking_confirmation
    end
  end

  delete '/dashboard' do
    session[:user_id] = nil
    redirect to '/'
  end

  post '/charge' do
  customer = Stripe::Customer.create(
    :email => 'customer@example.com',
    :source  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :amount      => ((@booking.end_date - @booking.start_date-1)*@listing.price_per_night).to_f,
    :description => 'Sinatra Charge',
    :currency    => 'usd',
    :customer    => customer.id
  )

  erb :payment_confirmation
end

  delete '/users' do
    session[:user_id] = nil
    redirect to '/'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end
  run! if app_file == $0
end
