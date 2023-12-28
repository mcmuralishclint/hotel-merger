require 'rails_helper'

RSpec.describe Api::V1::HotelsController, type: :controller do
  describe 'GET #search' do
    context 'with valid search parameters' do
      it 'returns a list of hotels by destination id' do
        get :search, params: { search_type: 'destination_id', search_value: 123 }
        expect(response).to have_http_status(:ok)
      end

      it 'returns a list of hotels by hotel id' do
        get :search, params: { search_type: 'id', search_value: 123 }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with missing search parameters' do
      it 'returns an unprocessable entity status' do
        get :search
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid search type' do
      it 'returns an unprocessable entity status' do
        get :search, params: { search_type: 'invalid_type', search_value: 123 }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
