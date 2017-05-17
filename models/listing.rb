class Listing

  include DataMapper::Resource

  property :id,              Serial
  property :property_name,   String
  property :description,     Text
  property :price_per_night, Fixnum
  property :user_id,         Serial

  belongs_to :user
end
