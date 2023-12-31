# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::HotelsController, type: :controller do
  describe 'GET #search' do
    context 'with valid search parameters' do
      it 'returns a list of hotels by destination id' do
        get :search, params: { type: 'destination_id', value: 123 }
        expect(response).to have_http_status(:ok)
      end

      it 'returns a list of hotels by hotels id' do
        get :search, params: { type: 'id', value: 123 }
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
        get :search, params: { type: 'invalid_type', value: 123 }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
