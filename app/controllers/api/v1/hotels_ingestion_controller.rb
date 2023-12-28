
module Api
  module V1
    class HotelsIngestionController < ApplicationController
      def ingest
        Thread.new do
          HotelsIngestionService.new(params["suppliers"]).ingest
        end
        render json: { message: 'success' }, status: :ok
      end
    end
  end
end
