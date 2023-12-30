# frozen_string_literal: true

module Supplier
  module Builder
    class BaseBuilder
      def initialize(params)
        @hotel_params = params
      end

      def build_params
        params = build_basic_attributes || {}
        params.merge!(build_location_attributes) if build_location_attributes.present?
        params.merge!(build_amenities_attributes) if build_amenities_attributes.present?
        params.merge!(build_images_attributes) if build_images_attributes.present?
        params.merge!(build_booking_condition_attributes) if build_booking_condition_attributes.present?
        params.with_indifferent_access
      end

      private

      def build_basic_attributes; end

      def build_location_attributes; end

      def build_amenities_attributes; end

      def build_images_attributes; end

      def build_booking_condition_attributes; end
    end
  end
end
