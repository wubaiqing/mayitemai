class Cpanel::BrandsController < Cpanel::ApplicationController

  before_action :set_brand, only: [:show, :edit, :update, :destroy]

  # 管理
  def index
    @brands = Brand.all.desc(:id).paginate(:page => params[:page], :per_page => 10)

    keywords = params[:q] || ''
    if !keywords.blank?
      @brands = Brand.find_by_wangwang(keywords)
       .desc(:id).paginate(:page => params[:page], :per_page => 10)
    end
  end

  # 新建
  def new
    @brand = Brand.new
    @cates = Cate.find_by_publish.all
  end

  # 修改
  def edit
    @cates = Cate.find_by_publish.all
  end

  # 创建
  def create
    @brand = Brand.new(brand_params)
    @cates = Cate.find_by_publish.all

    if @brand.save
      redirect_to cpanel_brands_url
    else
      render :new
    end
  end

  # 更新
  def update
    @cates = Cate.find_by_publish.all
    if @brand.update(brand_params)
      redirect_to cpanel_brands_url
    else
      render :new
    end
  end

  private
  def set_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params[:brand].permit(:cate_id, :name, :wangwang, :logo_picture, :desc_picture, :banner_picture, :sale, :sort)
  end
end
