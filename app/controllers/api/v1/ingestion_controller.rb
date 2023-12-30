# frozen_string_literal: true

module Api
  module V1
    class IngestionController < ApplicationController
      def ingest
        Thread.new do
          Ingest::HotelsIngestionService.new(params['suppliers']).ingest
        end
        render json: { message: 'in-progress' }, status: :ok
      end
    end
  end
end
