class BrandsController < ApplicationController

  before_action :set_brand, only: [:show, :edit, :update, :destroy]

  # 管理
  def index
    @brands = Brand.all.paginate(:page => params[:page], :per_page => 10)
  end

  # 新建
  def new
    @brand = Brand.new
  end

  # 修改
  def edit
  end

  # 创建
  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      redirect_to brands_url
    else
      render :new
    end
  end

  # 更新
  def update
    if @brand.update(brand_params)
      redirect_to brands_url
    else
      render :new
    end
  end

  private
  def set_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params[:brand].permit(:name, :wangwang, :banner_picture, :recommend_picture, :state)
  end
end
