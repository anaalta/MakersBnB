class Listing
  
  include DataMapper::Resource

  property :id,        Serial
  property :property,  String

  belongs_to :user 
end
