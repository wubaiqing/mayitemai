class DetailsController < ApplicationController

  before_action :set_detail, only: [:show]

  def show
    set_seo_meta('蚂蚁特卖-大牌商品 超值特卖！')
    @goods = Good.good_collection(@brand.id, @brand.wangwang)
  end

  private
    def set_detail
      @brand = Brand.find_by_id(params[:id])
    end
end
