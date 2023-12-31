# frozen_string_literal: true

module Api
  module V1
    ALLOWED_SEARCH_TYPE = %w[destination_id id].freeze

    class HotelsController < ApplicationController
      before_action :validate_search_params

      def search
        search_type = params[:type]
        search_value = params[:value]

        cache_key = "#{search_type}:#{search_value}"
        serialized_hotels = Rails.cache.fetch(cache_key)

        if serialized_hotels.nil?
          hotels = Hotel.where(search_type => search_value).to_a
          serialized_hotels = ActiveModelSerializers::SerializableResource.new(hotels, each_serializer: HotelSerializer).as_json
          Rails.cache.write(cache_key, serialized_hotels) unless serialized_hotels.empty?
        end

        render json: serialized_hotels || []
      end

      private

      def validate_search_params
        unless params[:type].present? && params[:value].present?
          return render json: { error: 'Search parameters are missing' }, status: :unprocessable_entity
        end

        return if ALLOWED_SEARCH_TYPE.include?(params[:type])

        render json: { error: 'Invalid search type' }, status: :unprocessable_entity
      end
    end
  end
end
