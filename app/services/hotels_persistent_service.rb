# The purpose of this class is to provide an interface to get granular
# control over each attribute. The class is open for future improvements to
# control the values to retain post merge
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
    validated_params['name'] = validate_and_modify_name(@hotel_params['name']&.strip)
    validated_params['description'] = validate_and_modify_description(@hotel_params['description'])
    validated_params['destination_id'] = validate_and_modify_destination_id(@hotel_params['destination_id'])
    validated_params['location_attributes'] = validate_and_modify_location_attributes(@hotel_params['location_attributes'])
    validated_params['amenities_attributes'] = validate_and_modify_amenities_attributes(@hotel_params['amenities_attributes'])
    validated_params['images_attributes'] = validate_and_modify_images_attributes(@hotel_params['images_attributes'])
    validated_params['booking_conditions_attributes'] = validate_and_modify_booking_conditions_attributes(@hotel_params['booking_conditions_attributes'])
    validated_params.reject! { |_k, v| v.nil? }
    validated_params
  end

  def validate_and_modify_name(name)
    if name.length > (@hotel&.name&.length || 0)
      name
    else
      @hotel.name
    end
  end

  def validate_and_modify_description(description)
    if (description&.length || 0) > (@hotel&.description&.length || 0)
      description
    else
      @hotel.description
    end
  end

  def validate_and_modify_destination_id(destination_id)
    destination_id
  end

  def validate_and_modify_location_attributes(location_attributes)
    model_location = @hotel.location
    updated_attributes = {}
    updated_attributes['lat'] = [model_location&.lat || 0, location_attributes['lat'] || 0].max if location_attributes['lat'].present?
    updated_attributes['lng'] = [model_location&.lng || 0, location_attributes['lng'] || 0].max if location_attributes['lng'].present?
    updated_attributes['address'] = if location_attributes['address'].present? && location_attributes['address'].length > (model_location&.address&.length || 0)
                                      location_attributes['address']
                                    else
                                      model_location.address
                                    end

    updated_attributes['city'] = if location_attributes['city'].present? && location_attributes['city'].length > (model_location&.city&.length || 0)
                                      location_attributes['city']
                                    else
                                      model_location&.city
                                    end

    updated_attributes['country'] = if location_attributes['country'].present? && location_attributes['country'].length > (model_location&.country&.length || 0)
                                      location_attributes['country']
                                    else
                                      model_location&.country
                                    end
    updated_attributes
  end

  def validate_and_modify_amenities_attributes(amenities_attributes)
    cleaned_amenities_attributes = []
    amenities = amenities_attributes.map{|amenity| amenity.merge(hotel_id: @hotel_params['hotel_id'])} rescue []
    amenities.each do |amenity|
      if Amenity.where(amenity).empty?
        cleaned_amenities_attributes << amenity.reject{|k,v| k=="hotel_id"}
      end
    end
    cleaned_amenities_attributes
  end

  def validate_and_modify_images_attributes(images_attributes)
    cleaned_images_attributes = []
    images = images_attributes.map{|image| image.merge(hotel_id: @hotel_params['hotel_id'])} rescue []
    images.each do |image|
      if Image.where(image).empty?
        cleaned_images_attributes << image.reject{|k,v| k=="hotel_id"}
      end
    end
    cleaned_images_attributes
  end

  def validate_and_modify_booking_conditions_attributes(booking_conditions_attributes)
    booking_conditions_attributes ||= []
    cleaned_booking_conditions_attributes = []
    booking_conditions_attributes.each do |booking_condition|
      if BookingCondition.where(booking_condition.merge(hotel_id: @hotel_params['hotel_id'])).empty?
        cleaned_booking_conditions_attributes << booking_condition
      end
    end
    cleaned_booking_conditions_attributes
  end
end