class Cpanel::BrandsController < Cpanel::ApplicationController

  before_action :get_brand, only: [:edit, :update]

  # 管理
  def index

    # 翻页
    @brands = Brand.all.desc(:id).paginate(:page => params[:page], :per_page => 10)

    # 搜索条件
    keywords = params[:q] || ''

    if !keywords.blank?
      # 旺旺搜索
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

  # 根据ID查询专题
  def get_brand
    @brand = Brand.find(params[:id])
  end

  # 限制输入
  def brand_params
    params[:brand].permit(:cate_id, :name, :wangwang, :logo_picture, :desc_picture, :banner_picture, :sale, :sort)
  end
end
