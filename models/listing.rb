class Listing

  include DataMapper::Resource

  property :id,              Serial
  property :property_name,   String
  property :description,     Text
  property :price_per_night, Fixnum
  property :available_from,  Date
  property :available_until, Date
  
  belongs_to :user
end
