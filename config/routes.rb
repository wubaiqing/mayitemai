Rails.application.routes.draw do


  resources :brands, :goods, :homes

  resources :photos do
    collection do
      get 'search'
    end
  end

  resources :brands do
    collection do
      get 'search'
    end
  end

  root 'homes#index'

end
