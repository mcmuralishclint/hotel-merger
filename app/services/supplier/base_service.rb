module Supplier
  class BaseService
    def fetch_and_save_hotel_info
      hotels = fetch_hotels
      hotels.each do |hotel_params|
        hotel_params = parse_hotel_params(hotel_params)
        save_hotel_info(hotel_params)
      end
    end

    private

    def path
    end

    def fetch_hotels
      response = HTTParty.get(path)
      JSON.parse(response.body) rescue []
    end

    def save_hotel_info(hotel_params)
      HotelsPersistentService.new(hotel_params).validate_and_save
    end

    def parse_hotel_params(hotel_params)
      hotel_params
    end
  end
end