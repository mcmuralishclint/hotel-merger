# frozen_string_literal: true

module Api
  module V1
    ALLOWED_SEARCH_TYPE = %w[destination_id id].freeze

    class HotelsController < ApplicationController
      before_action :validate_search_params

      def search
        search_type = params[:search_type]
        search_value = params[:search_value]

        hotels = Hotel.where(search_type => search_value)
        render json: hotels, each_serializer: HotelSerializer
      end

      private

      def validate_search_params
        unless params[:search_type].present? && params[:search_value].present?
          return render json: { error: 'Search parameters are missing' }, status: :unprocessable_entity
        end

        return if ALLOWED_SEARCH_TYPE.include?(params[:search_type])

        render json: { error: 'Invalid search type' }, status: :unprocessable_entity
      end
    end
  end
end
