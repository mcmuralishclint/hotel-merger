module Supplier
  class AcmeService < BaseService
    def parse_hotel_params(hotel_params)
      Supplier::Builder::AcmeBuilder.new(hotel_params).build_params
    end

    private

    def path
      "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme"
    end
  end
end