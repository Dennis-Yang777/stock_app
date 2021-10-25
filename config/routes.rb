Rails.application.routes.draw do
  root "stock_download#show"

  resource :stock_download do
    collection do
      post 'mutiple_create', to: 'stock_downloads#create_with_mutiple_time'
    end
  end

  resources :stocks
end
