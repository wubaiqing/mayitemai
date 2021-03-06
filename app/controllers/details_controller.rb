# coding: utf-8

# 专题
class DetailsController < ApplicationController

  before_action :get_brand, only: [:show]

  # 详情页
  def show
    @cates = Cate.cate_collections
    @goods = Good.good_collection(@brand.id, @brand.wangwang)
    @goods_cate= GoodsCate.find_by_brand_id(@brand.id)
    params[:id] = nil

  end

  def index
    
  end

  private

  # 查询专题，设置meta
  def get_brand
    set_seo_meta('蚂蚁特卖-大牌商品 超值特卖！')
    @brand = Brand.find_by_id(params[:id])
  end
end
