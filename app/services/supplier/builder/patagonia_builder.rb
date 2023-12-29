module Supplier
  module Builder
    class PatagoniaBuilder < BaseBuilder
      def build_basic_attributes
        {
          hotel_id: @hotel_params['id'],
          destination_id: @hotel_params['destination'],
          name: @hotel_params['name']&.strip,
          description: @hotel_params['info']&.strip
        }
      end

      def build_location_attributes
        {
          location_attributes: {
            lat: @hotel_params['lat'],
            lng: @hotel_params['lng'],
            address: @hotel_params['address']&.strip
          }
        }
      end

      def build_amenities_attributes
        { amenities_attributes: @hotel_params['amenities']&.map {
          |amenity| {
            name: amenity.strip.downcase,
            amenity_type: "General"
          }
        }
        }
      end

      def build_images_attributes
        images_attributes = {
          images_attributes: []
        }

        @hotel_params['images'].each do |category, images|
          images.each do |image|
            images_attributes[:images_attributes] << {
              hotel_id: @hotel_params['hotel_id'],
              image_type: category.to_s.capitalize,
              link: image['url'],
              description: image['description']
            }
          end
        end

        images_attributes
      end
    end
  end
end
