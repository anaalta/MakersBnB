
class Booking
  include DataMapper::Resource

  belongs_to :listing
  property :id,               Serial
  #property :property_id,     Serial
  #property :property_name,   String
  property :start_date,      Date
  property :end_date,        Date
  #property :price_per_night, Fixum
  property :number_of_days,  Fixnum
  property :total_price,     Fixnum

end
