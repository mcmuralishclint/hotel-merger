# frozen_string_literal: true

module Supplier
  class PaperfliesService < BaseService
    def parse_hotel_params(hotel_params)
      Supplier::Builder::PaperfliesBuilder.new(hotel_params).build_params
    end

    private

    def path
      'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies'
    end
  end
end
