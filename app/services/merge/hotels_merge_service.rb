# frozen_string_literal: true

module Merge
  class HotelsMergeService
    def initialize
      @hotels = RawData.pluck(:hotel_id).uniq
    end

    def perform
      merge(@hotels)
    end

    def merge(hotel_ids)
      merged_info = []
      hotel_ids.each do |hotel_id|
        hotels = RawData.where(hotel_id:)
        merged_params = {}
        merged_params[:id] = hotel_id
        merged_params[:destination_id] = merge_destination_ids(hotels.pluck(:destination_id))
        merged_params[:name] = merge_names(hotels.pluck(:name))
        merged_params[:description] = merge_descriptions(hotels.pluck(:description))
        merged_params[:location_attributes] = merge_locations(hotels.pluck(:location_attributes))
        merged_params[:amenities_attributes] = merge_amenities(hotels.pluck(:amenities_attributes))
        merged_params[:images_attributes] = merge_images(hotels.pluck(:images_attributes))
        merged_params[:booking_conditions_attributes] =
          merge_booking_conditions(hotels.pluck(:booking_conditions_attributes))
        merged_info << merged_params
      end
      merged_info
    end

    private

    def merge_destination_ids(destination_ids)
      destination_ids.group_by(&:itself).values.max_by(&:size).first
    end

    def merge_descriptions(descriptions)
      descriptions.max
    rescue StandardError
      nil
    end

    def merge_names(names)
      names.max
    end

    def merge_locations(locations)
      locations.map! { |location| eval(location) }
      locations.each_with_object({}) do |h, acc|
        h.each { |k, v| acc[k] = [acc[k], v].compact.max_by { |e| e.to_s.length } }
      end
    end

    def merge_amenities(amenities)
      merged_amenities = []

      amenities.each do |amenity_str|
        next if amenity_str.nil?

        amenity_hashes = eval(amenity_str)
        merged_amenities.concat(amenity_hashes)
      end

      merged_amenities.uniq
    end

    def merge_images(images)
      result = []

      images.each do |image_str|
        next if image_str.nil?

        images_hash = eval(image_str)

        images_hash.each do |image|
          next if result.any? { |img| img[:link] == image['link'] }

          result << {
            image_type: image['image_type'].capitalize,
            link: image['link'],
            description: image['description']
          }
        end
      end

      result
    end

    def merge_booking_conditions(booking_conditions)
      parsed_conditions = booking_conditions.compact.map { |str| JSON.parse(str.gsub('=>', ':')) }
      parsed_conditions.flatten.map { |hash| { condition: hash['condition'] } }
    end
  end
end
