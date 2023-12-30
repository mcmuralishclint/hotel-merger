# frozen_string_literal: true

module Ingest
  class HotelsIngestionService
    VALID_SUPPLIERS = %w[acme patagonia paperflies].freeze

    def initialize(suppliers)
      @suppliers = if suppliers == ['*']
                     VALID_SUPPLIERS
                   else
                     begin
                       VALID_SUPPLIERS & suppliers
                     rescue StandardError
                       []
                     end
                   end
    end

    def ingest
      @suppliers.each do |supplier|
        "Supplier::#{supplier.camelcase}Service".constantize.new.perform
      end
      merged_params = Merge::HotelsMergeService.new.perform
      merged_params.each do |merged_param|
        Persist::HotelPersistentService.new(merged_param).validate_and_save
      end
    end
  end
end
