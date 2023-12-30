module Ingest
  class HotelsIngestionService
    VALID_SUPPLIERS = ["acme", "patagonia", "paperflies"]

    def initialize(suppliers)
      @suppliers = if suppliers == ["*"]
                     VALID_SUPPLIERS
                   else
                     VALID_SUPPLIERS & suppliers rescue []
                   end
    end

    def ingest
      @suppliers.each do |supplier|
        ("Supplier::" + supplier.camelcase + "Service").constantize.new.perform
      end
      Merge::HotelsMergeService.new.perform
    end
  end
end