Rails.application.routes.draw do
  resources :brands
  resources :goods
  resources :homes
  resources :photos
  get "brands/search" => "brands#search", as: 'feed_node_topics'
  root 'homes#index'
end
