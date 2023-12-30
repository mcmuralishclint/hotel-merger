module Persist
  class HotelPersistentService < BaseService
    def validate_and_save
      hotel = Hotel.find_or_initialize_by id: @params[:id]
      hotel.update @params
    end
  end
end
