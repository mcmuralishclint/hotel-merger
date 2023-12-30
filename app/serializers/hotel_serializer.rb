# frozen_string_literal: true

class HotelSerializer < ActiveModel::Serializer
  attributes :id, :destination_id, :name, :description, :amenities, :images, :booking_conditions
  has_one :location, serializer: LocationSerializer

  def amenities
    object.amenities.group_by(&:amenity_type).transform_values { |amenity_list| amenity_list.map(&:name) }
  end

  def images
    object.images.group_by { |image| image.image_type.downcase }
          .transform_values { |images| images.map { |image| { link: image.link, description: image.description } } }
  end

  def booking_conditions
    object.booking_conditions.pluck(:condition)
  end
end
