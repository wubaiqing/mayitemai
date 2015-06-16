Rails.application.routes.draw do

  # 关于我们
  get '/document/about', to: 'document#about'

  # 联系我们
  get '/document/contact', to: 'document#contact'

  # 商户合作
  get '/document/supplier', to: 'document#supplier'

  # 详情页
  resources :home, :details

  # 网站首页
  root to: 'home#index'

  # 后台
  namespace :cpanel do

    # 首页
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

    resources :brands, :goods, :homes, :photos, :cates

  end

  # 用户系统
  devise_for :users, path: "account", controllers: {
    registrations: :account
  }

end
