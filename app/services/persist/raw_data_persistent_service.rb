module Persist
  class RawDataPersistentService < BaseService
    def validate_and_save
      validated_params = validate_params.with_indifferent_access
      RawData.upsert_from_params(validated_params)
    end

    private

    def validate_params
      validated_params = {}
      validated_params['hotel_id'] = @params['hotel_id']
      validated_params['source'] = @params['source']
      validated_params['name'] = validate_name(@params['name'])
      validated_params['description'] = validate_description(@params['description'])
      validated_params['destination_id'] = validate_destination_id(@params['destination_id'])
      validated_params['location_attributes'] = validate_location_attributes(@params['location_attributes'])
      validated_params['amenities_attributes'] = validate_amenities_attributes(@params['amenities_attributes'])
      validated_params['images_attributes'] = validate_images_attributes(@params['images_attributes'])
      validated_params['booking_conditions_attributes'] = validate_booking_conditions_attributes(@params['booking_conditions_attributes'])
      validated_params.reject! { |_k, v| v.nil? }
      validated_params
    end

    def validate_name(name)
      name&.strip
    end

    def validate_description(description)
      description&.strip
    end

    def validate_destination_id(destination_id)
      destination_id
    end

    def validate_location_attributes(location_attributes)
      location_attributes
    end

    def validate_amenities_attributes(amenities_attributes)
      amenities_attributes
    end

    def validate_images_attributes(images_attributes)
      images_attributes
    end

    def validate_booking_conditions_attributes(booking_conditions_attributes)
      booking_conditions_attributes
    end
  end
end