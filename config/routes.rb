Rails.application.routes.draw do

  namespace :cpanel do
    resources :cates
  end
  resources :cpanel_cates
  # 用户系统
  devise_for :users, :path => 'accounts', controllers: {
    registrations: :account,
  }, :path_names => {
    :sign_in => 'login',
    :sign_out => 'logout'
  }

  # 关于我们
  get '/document/about', to: 'document#about'

  # 联系我们
  get '/document/contact', to: 'document#contact'

  # 商户合作
  get '/document/supplier', to: 'document#supplier'

  # 详情页
  resources :home, :details

  root to: 'home#index'


  namespace :cpanel do

    # 后台首页
    root to: 'homes#index'


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

  end


end
