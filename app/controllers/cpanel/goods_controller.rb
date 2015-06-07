class Cpanel::GoodsController < Cpanel::ApplicationController
  before_action :set_good, only: [:show, :edit, :update, :destroy]

  # 管理
  def index
    @goods = Good.all.desc(:id).paginate(:page => params[:page], :per_page => 10)

    taobao_id = params[:taobao_id] || ''
    wangwang = params[:wangwang] || ''

    if !taobao_id.blank?
      @goods = Good.find_by_taobao_id(taobao_id)
       .desc(:id).paginate(:page => params[:page], :per_page => 10)
    end

    if !wangwang.blank?
      @goods = Good.find_by_wangwang(wangwang)
       .desc(:id).paginate(:page => params[:page], :per_page => 10)
    end

  end

  # 新增
  def new
    @good = Good.new
    @brands = Brand.find_by_publish.all
  end

  # 编辑
  def edit
    @brands = Brand.find_by_publish.all
  end

  # 创建
  def create
    @good = Good.new(good_params)
    @brands = Brand.find_by_publish.all

    if @good.save
      redirect_to cpanel_goods_url
    else
      render :new
    end
  end

  # 修改
  def update
    @brands = Brand.find_by_publish.all
    if @good.update(good_params)
      redirect_to cpanel_goods_url
    else
      render :new
    end
  end

  def fetch_taobao_repositories
    taobao_id = params[:taobao_id] || ''

    item = ''
    if !taobao_id.blank?
      item = Good.fetch_taobao_repositories(taobao_id)
    end

    # 七牛图片地址
    render json: item
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_good
      @good = Good.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def good_params
      params[:good].permit(:taobao_id, :taobao_url, :title, :original_price, :price, :picture_url, :sort, :brand_id)
    end
end
