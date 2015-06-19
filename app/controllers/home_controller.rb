class HomeController < ApplicationController
  def index
    set_seo_meta('蚂蚁特卖-大牌商品 超值特卖！')
    @brands = Brand.brands_collection
    @cates = Cate.cate_collections
  end


  def show
    set_seo_meta('蚂蚁特卖-大牌商品 超值特卖！')
    @brands = Brand.find_by_cate_id(params[:id]).all
    @cates = Cate.cate_collections
    render "index"
  end

end
