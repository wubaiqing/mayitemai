# coding: utf-8

# 首页
class HomeController < ApplicationController

  # 设置Mata，获取专题信息
  before_action :get_cate, only: [:index, :show]

  # 首页
  def index
    @brands = Brand.brands_collection
  end

  # 详情页
  def show
    @brands = Brand.find_by_cate_id(params[:id]).all
    render action: :index
  end


  private

  # 查询分类，设置meta
  def get_cate
    set_seo_meta('蚂蚁特卖-大牌商品 超值特卖！')
    @cates = Cate.cate_collections
  end

end
