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
        "男鞋" => "1",
        "女鞋" => "2",
        "童鞋" => "3",
        "男装" => "4",
        "女装" => "5",
        "童装" => "6",
        "饰品" => "7",
        "彩妆" => "8",
        "护肤" => "9",
        "食品" => "10",
        "饮料" => "11",
        "妈妈" => "12",
        "宝宝" => "13",
        "家居" => "14",
        "配饰" => "15",
        "个护" => "16",
        "男包" => "17",
        "女包" => "18",
        "童包" => "19",
      }
    end

    # 添加限制
    def hao_params
      params[:hao].permit(:taobao_id, :taobao_url, :title, :price, :picture_url, :tagid, :site, :site_url, :post, :state)
    end
end

