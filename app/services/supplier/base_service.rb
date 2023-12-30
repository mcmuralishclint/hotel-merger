module Supplier
  class BaseService
    def perform
      hotels = fetch_hotels
      hotels.each do |hotel_params|
        hotel_params = parse_hotel_params(hotel_params)
        persist_raw_data(hotel_params)
      end
    end

    private

    def path
    end

    def fetch_hotels
      response = HTTParty.get(path)
      JSON.parse(response.body) rescue []
    end

    def parse_hotel_params(hotel_params)
      hotel_params
    end

    def persist_raw_data(hotel_params)
      Persist::RawDataPersistentService.new(hotel_params).validate_and_save
    end
  end
end