module Supplier
  class PatagoniaService < BaseService
    def parse_hotel_params(hotel_params)
      Supplier::Builder::PatagoniaBuilder.new(hotel_params).build_params
    end

    private

    def path
      "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia"
    end
  end
end
