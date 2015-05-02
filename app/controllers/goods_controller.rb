class GoodsController < ApplicationController
  before_action :set_good, only: [:show, :edit, :update, :destroy]

  # 管理
  def index
    @goods = Good.all
  end

  # 新增
  def new
    @good = Good.new
  end

  # 编辑
  def edit
  end

  # 创建
  def create
    @good = Good.new(good_params)

    if @good.save
      redirect_to goods_url
    else
      render :new
    end
  end

  # 修改
  def update
    if @good.save
      redirect_to goods_url
    else
      render :new
    end
  end

  def fetch_taobao_repositories
    taobao_id = params[:taobao_id] || '38834041029'

    item = Good.fetch_taobao_repositories(taobao_id)

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
