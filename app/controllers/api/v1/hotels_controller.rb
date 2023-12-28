module Api
  module V1
    ALLOWED_SEARCH_TYPE = ["destination_id", "id"]

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

        unless ALLOWED_SEARCH_TYPE.include?(params[:search_type])
          return render json: { error: 'Invalid search type' }, status: :unprocessable_entity
        end
      end
    end
  end
end
