
class Bookings
  include DataMapper::Resource

  belongs_to :listing
  property :property_id,     Serial
  property :property_name,   String
  property :start_date,      Date
  property :end_date,        Date
  property :price_per_night, Fixum
  property :number_of_days,  Fixum
  property :total_price,     Fixum

end
