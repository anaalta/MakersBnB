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
  property :confirmed,       Boolean, :default  => false
  has n,   :listings

  validates_confirmation_of :password
  validates_presence_of :email
  validates_format_of :email, :as => :email_address

  def confirm_registration
    send_confirmation_email
  end

  def password=(password)
    @password = Password.create(password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_hash) == password
      if user.confirmed
        user
      else
        nil
      end
    else
      nil
    end
  end

end
