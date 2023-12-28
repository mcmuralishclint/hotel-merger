
module Api
    module V1
      class HotelsController < ApplicationController
        def search
          hotel = Hotel.first
          render json: hotel, serializer: HotelSerializer
        end
      end
    end
  end
  