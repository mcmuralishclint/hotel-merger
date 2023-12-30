module Supplier
  module Builder
    class PaperfliesBuilder < BaseBuilder
      def build_basic_attributes
        {
          hotel_id: @hotel_params['hotel_id'],
          destination_id: @hotel_params['destination_id'],
          name: @hotel_params['hotel_name']&.strip,
          description: @hotel_params['details']&.strip,
          source: "PAPERFLIES"
        }
      end

      def build_location_attributes
        {
          location_attributes: {
            address: @hotel_params['location']['address']&.strip,
            country: @hotel_params['location']['country']&.strip
          }
        }
      end

      def build_amenities_attributes
        attributes = {
          amenities_attributes: []
        }

        @hotel_params['amenities'].each do |type, items|
          items.each do |amenity_name|
            attributes[:amenities_attributes] << {
              amenity_type: type.camelcase,
              name: amenity_name.strip.downcase
            }
          end
        end

        attributes
      end

      def build_images_attributes
        images_attributes = {
          images_attributes: []
        }

        @hotel_params['images'].each do |category, images|
          images.each do |image|
            images_attributes[:images_attributes] << {
              # hotel_id: @hotel_params['hotel_id'],
              image_type: category.to_s.capitalize,
              link: image['link'],
              description: image['caption']
            }
          end
        end

        images_attributes
      end

      def build_booking_condition_attributes
        attributes = {
          booking_conditions_attributes: []
        }

        @hotel_params['booking_conditions'].each do |condition|
          attributes[:booking_conditions_attributes] << {
            condition: condition
          }
        end

        attributes
      end
    end
  end
end
