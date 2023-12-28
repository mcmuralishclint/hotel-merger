class HotelSerializer < ActiveModel::Serializer
  attributes :id, :destination_id, :name, :description

  has_one :location, serializer: LocationSerializer
  has_many :amenities, serializer: AmenitySerializer
  has_many :images, serializer: ImageSerializer
  has_many :booking_conditions, serializer: BookingConditionSerializer
end