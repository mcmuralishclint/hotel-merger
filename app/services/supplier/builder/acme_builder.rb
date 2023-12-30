module Supplier
  module Builder
    class AcmeBuilder < BaseBuilder
      private

      def build_basic_attributes
        {
          hotel_id: @hotel_params['Id'],
          destination_id: @hotel_params['DestinationId'],
          name: @hotel_params['Name'].strip,
          description: @hotel_params['Description'].strip,
          source: "ACME"
        }
      end

      def build_location_attributes
        {
          location_attributes: {
            lat: @hotel_params['Latitude'],
            lng: @hotel_params['Longitude'],
            address: @hotel_params['Address'].strip,
            city: @hotel_params['City'].strip,
            country: @hotel_params['Country'].strip
          }
        }
      end

      def build_amenities_attributes
        { amenities_attributes: @hotel_params['Facilities'].map {
          |amenity| {
            name: amenity.strip.downcase,
            amenity_type: "General"
          }
        }
        }
      end
    end
  end
end
