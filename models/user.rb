require 'bcrypt'

class User
  include DataMapper::Resource
  include BCrypt

  attr_reader :password, :email
  attr_accessor :password_confirmation

  property :id,              Serial
  property :email,           String,  required: true
  property :first_name,      String,  required: true
  property :last_name,       String,  required: true
  property :password_hash,   Text

  has n, :listings
  has n, :bookings

  validates_confirmation_of :password
  validates_presence_of :email
  validates_format_of :email, :as => :email_address


  def password=(password)
    @password = Password.create(password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_hash) == password
      user
    else
      nil
    end
  end

end
