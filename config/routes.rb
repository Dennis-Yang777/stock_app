Rails.application.routes.draw do
  root "api/v1/download_stocks#show"

  namespace :api do
    namespace :v1 do
      resource :download_stocks, only: %w[show create]
    end
  end

  resources :stocks, only: %W[index show] do
    collection do
      get 'search', to: 'stocks#search'
    end
  end
end
