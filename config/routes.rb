Rails.application.routes.draw do
  resources :brands
  resources :goods
  resources :homes
  resources :photos

  get "brands/search" => "brands#search", as: 'brands_search'

  root 'homes#index'
end
