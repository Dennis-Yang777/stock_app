Rails.application.routes.draw do
  root "stock_downloads#index"
  resources :stock_downloads do
    collection do
      post 'mutiple_create', to: 'stock_downloads#create_with_mutiple_time'
    end
  end
end
