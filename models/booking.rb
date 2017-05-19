
class Booking
  include DataMapper::Resource

  property :id,               Serial
  property :start_date,       Date
  property :end_date,         Date
  #property :number_of_days,  Fixnum
  property :total_price,     Fixnum

  belongs_to :listing
  belongs_to :user
end
