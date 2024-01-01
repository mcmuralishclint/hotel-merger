# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :hotels do
        collection do
          get :search
        end
      end

      resources :ingestion do
        collection do
          post :ingest
        end
      end
    end
  end
end
