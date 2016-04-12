# coding: utf-8

# 商品管理
class Cpanel::HaosController < Cpanel::ApplicationController

  before_action :get_good, only: [:edit, :update]
  before_action :get_tagids


  # 管理
  def index

    @query = Hao.where(state: 1).all

    # 翻页
    @haos = Hao.all.desc(:id).paginate(:page => params[:page], :per_page => 10)

    # 搜索条件
    taobao_id = params[:taobao_id] || ''

    if !taobao_id.blank?
      # 淘宝ID搜索
      @haos = Hao.find_by_taobao_id(taobao_id)
       .desc(:id).paginate(:page => params[:page], :per_page => 10)
    end

  end

  # 新增
  def new

    @hao = Hao.new
  end

  # 编辑
  def edit
  end

  # 创建
  def create
    @hao = Hao.new(hao_params)
    if @hao.save
      redirect_to cpanel_haos_url
    else
      render :new
    end
  end

  # 修改
  def update
    if @hao.update(hao_params)
      redirect_to cpanel_haos_url
    else
      render :new
    end
  end



  private

    # 根据ID查询专题
    def get_good
      @hao = Hao.find(params[:id])
    end

    def get_tagids
      @tagids = {
        "面部护理" => "1",
        "彩妆香气" => "2",
        "男士护肤" => "3",
      }
    end

    # 添加限制
    def hao_params
      params[:hao].permit(:taobao_id, :taobao_url, :title, :price, :original_price, :picture_url, :tagid, :site, :site_url, :post, :state)
    end
end

