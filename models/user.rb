require 'bcrypt'

class User
  include DataMapper::Resource
  include BCrypt

  attr_reader :password, :email
  attr_accessor :password_confirmation

  property :id,              Serial
  property :email,           String
  property :first_name,      String
  property :last_name,       String
  property :password_hash,   Text
  validates_confirmation_of :password

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
