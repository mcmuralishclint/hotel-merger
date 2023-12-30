# frozen_string_literal: true

# app/models/hotels.rb
class RawData
  include Mongoid::Document
  field :hotel_id, type: String
  field :source, type: String
  field :name, type: String
  field :description, type: String
  field :destination_id, type: String
  field :location_attributes, type: String
  field :amenities_attributes, type: String
  field :images_attributes, type: String
  field :booking_conditions_attributes, type: String

  def self.upsert_from_params(validated_params)
    hotel_raw_record = RawData.find_or_initialize_by(hotel_id: validated_params[:hotel_id],
                                                     source: validated_params[:source])
    hotel_raw_record.attributes = validated_params
    hotel_raw_record.save!
  end
end
