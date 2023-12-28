class HotelsPersistentService
  def initialize(hotel_params)
    @hotel_params = hotel_params.with_indifferent_access
    @hotel = Hotel.find_or_initialize_by(id: @hotel_params['hotel_id'])
  end
  def validate_and_save
    validated_params = validate_params
    @hotel.update!(validated_params)
  end

  private

  def validate_params
    validated_params = {}
    validated_params['name'] = validate_name(@hotel_params['name']&.strip)
    validated_params['description'] = validate_description(@hotel_params['description'])
    validated_params['destination_id'] = validate_destination_id(@hotel_params['destination_id'])
    validated_params['location_attributes'] = validate_location_attributes(@hotel_params['location_attributes'])
    validated_params['amenities_attributes'] = validate_amenities_attributes(@hotel_params['amenities_attributes'])
    validated_params['images_attributes'] = validate_images_attributes(@hotel_params['images_attributes'])
    validated_params['booking_conditions_attributes'] = validate_booking_conditions_attributes(@hotel_params['booking_conditions_attributes'])
    validated_params
  end

  def validate_name(name)
    if name.length > (@hotel&.name&.length || 0)
      name
    else
      @hotel.name
    end
  end

  def validate_description(description)
    if description.length > (@hotel&.description&.length || 0)
      description
    else
      @hotel.description
    end
  end

  def validate_destination_id(destination_id)
    destination_id
  end

  def validate_location_attributes(location_attributes)
    model_location = @hotel.location
    updated_attributes = {}

    updated_attributes['lat'] = [model_location.lat, location_attributes['lat']].max if location_attributes['lat'].present?
    updated_attributes['lng'] = [model_location.lng, location_attributes['lng']].max if location_attributes['lng'].present?
    updated_attributes['address'] = if location_attributes['address'].present? && location_attributes['address'].length > model_location.address.length
                                      location_attributes['address']
                                    else
                                      model_location.address
                                    end

    updated_attributes['city'] = if location_attributes['city'].present? && location_attributes['city'].length > model_location.city.length
                                      location_attributes['city']
                                    else
                                      model_location.city
                                    end

    updated_attributes['country'] = if location_attributes['country'].present? && location_attributes['country'].length > model_location.country.length
                                      location_attributes['country']
                                    else
                                      model_location.country
                                    end
    updated_attributes
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