Rails.application.routes.draw do
  root "stock_downloads#index"
  resources :stock_downloads
end
