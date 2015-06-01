Rails.application.routes.draw do

  resources :details
  devise_for :users

  # 关于我们
  get '/document/about', to: 'document#about'
  get '/document/contact', to: 'document#contact'
  get '/document/supplier', to: 'document#supplier'

  # 获取淘宝商品
  resources :goods do
    collection do
      get 'fetch_taobao_repositories'
    end
  end

  # 协议搜索
  resources :brands do
    collection do
      get 'search'
    end
  end



  resources :brands, :goods, :homes, :photos

  root 'homes#index'

end
