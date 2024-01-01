require 'swagger_helper'

RSpec.describe 'api/v1/hotels', type: :request do
  path '/api/v1/hotels/search' do
    parameter name: :type, in: :query, type: :string, required: true, description: 'Type of search (destination_id or id)'
    parameter name: :value, in: :query, type: :string, required: true, description: 'Value to search for'
    parameter name: :page, in: :query, type: :integer, default: 1, description: 'Page number for pagination'
    parameter name: :per_page, in: :query, type: :integer, default: 1, description: 'Number of results per page'



    get('search hotels') do
      tags 'Hotels'
      produces 'application/json'

      response '200', 'Retrieved hotel data' do
        let(:type) {"destination_id"}
        let(:value) {"5432"}
        let(:page) {1}
        let(:per_page) {1}
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :string },
                   destination_id: { type: :integer },
                   name: { type: :string },
                   description: { type: :string },
                   amenities: {
                     type: :object,
                     properties: {
                       General: { type: :array, items: { type: :string } },
                       Room: { type: :array, items: { type: :string } }
                     }
                   },
                   images: {
                     type: :object,
                     properties: {
                       rooms: {
                         type: :array,
                         items: {
                           properties: {
                             link: { type: :string },
                             description: { type: :string }
                           }
                         }
                       },
                       amenities: {
                         type: :array,
                         items: {
                           properties: {
                             link: { type: :string },
                             description: { type: :string }
                           }
                         }
                       },
                       site: {
                         type: :array,
                         items: {
                           properties: {
                             link: { type: :string },
                             description: { type: :string }
                           }
                         }
                       }
                     }
                   },
                   booking_conditions: { type: :array, items: { type: :string } },
                   location: {
                     type: :object,
                     properties: {
                       lat: { type: :number, format: :float },
                       lng: { type: :number, format: :float },
                       address: { type: :string },
                       city: { type: :string },
                       country: { type: :string }
                     }
                   }
                 },
                 required: %w[id destination_id name description amenities images booking_conditions location] # Adjust required properties as needed
               }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:type) {""}
        let(:value) {""}
        let(:page) {1}
        let(:per_page) {1}
        run_test!
      end
    end
  end
end
