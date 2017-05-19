
class Days
  include DataMapper::Resource

  property :id,               Serial
  property :available,        Boolean
  property :date,             Date

  belongs_to :listings

end
