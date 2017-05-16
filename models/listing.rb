class Listing

  include DataMapper::Resource

  property :id,              Serial
  property :property_name,   String
  property :description,     Text
  property :price_per_night, Fixnum

  belongs_to :user
end
