# coding: utf-8

# 专题分类管理
class Cpanel::GoodsCatesController < Cpanel::ApplicationController

  before_action :set_goods_cate, only: [:show, :edit, :update, :destroy]

  # 管理
  def index
    @brands = Brand.all
    @goods_cates = GoodsCate.all.desc(:id).paginate(:page => params[:page], :per_page => 10)
  end

  # 新建
  def new
    @brands = Brand.find_by_publish.all
    @goods_cate = GoodsCate.new
  end

  # 创建
  def create
    @goods_cate = GoodsCate.new(goods_cate_params)

    if @goods_cate.save
      redirect_to cpanel_goods_cates_url
    else
      render :new
    end
  end

  # 修改
  def update
    if @goods_cate.update(goods_cate_params)
      redirect_to cpanel_goods_cates_url
    else
      render :new
    end
  end


  private

    # 根据ID查询分类
    def set_goods_cate
      @goods_cate = GoodsCate.find(params[:id])
      @brands = Brand.all
    end

    # 添加限制
    def goods_cate_params
      params[:goods_cate].permit(:name, :sort, :state, :brand_id)
    end
end
