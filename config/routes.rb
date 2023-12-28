Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :hotels do
        collection do
          get :search
        end
      end

      resources :hotels_ingestion do
        collection do
          post :ingest
        end
      end
    end
  end
end
