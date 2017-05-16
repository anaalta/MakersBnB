require 'bcrypt'

class User
  include DataMapper::Resource
  include BCrypt

  property :id,              Serial
  property :email,           String
  property :first_name,      String
  property :last_name,       String
  property :password_hash,   Text

  has n, :listings

  attr_reader :password

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
