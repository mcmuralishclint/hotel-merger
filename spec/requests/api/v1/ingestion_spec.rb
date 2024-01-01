require 'swagger_helper'

RSpec.describe 'api/v1/ingestion', type: :request do
  path '/api/v1/ingestion/ingest' do
    post('Ingest data from suppliers') do
      tags 'Ingestion'
      consumes 'application/json'
      parameter name: :suppliers, in: :body, schema: {
        type: :object,
        properties: {
          suppliers: {
            type: :array,
            items: {
              type: :string
            }
          }
        },
        required: ['suppliers'],
        description: 'Use ["*"] to ingest from all the suppliers, ["acme"] from acme only, ["acme","patagonia"] from acme and patagonia only'
      }

      # Example request for ingesting all suppliers
      let(:all_suppliers) { { suppliers: ["*"] } }
      let(:specific_suppliers) { { suppliers: ["acme", "patagonia", "paperflies"] } }

      # Example response for successful ingestion
      response '200', 'Data ingestion started' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }
        run_test!
      end

      # Example response for unsuccessful request
      response '422', 'Unprocessable Entity' do
        run_test!
      end
    end
  end
end
