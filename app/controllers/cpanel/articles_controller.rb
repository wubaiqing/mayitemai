# coding: utf-8

# 商品管理
class Cpanel::ArticlesController < Cpanel::ApplicationController

  before_action :get_good, only: [:edit, :update]

  # 管理
  def index

    # 翻页
    @goods = Good.all.desc(:id).paginate(:page => params[:page], :per_page => 10)

    # 搜索条件
    taobao_id = params[:taobao_id] || ''
    wangwang = params[:wangwang] || ''

    if !taobao_id.blank?
      # 淘宝ID搜索
      @goods = Good.find_by_taobao_id(taobao_id)
       .desc(:id).paginate(:page => params[:page], :per_page => 10)
    end

    if !wangwang.blank?
      # 旺旺搜索
      @goods = Good.find_by_wangwang(wangwang)
       .desc(:id).paginate(:page => params[:page], :per_page => 10)
    end

  end

  # 新增
  def new
    @good = Good.new
    @brands = Brand.find_by_publish.all
    @goods_cate = GoodsCate.find_by_brand_id(-1).all
  end

  # 编辑
  def edit
    @brands = Brand.find_by_publish.all
    @goods_cate = GoodsCate.find_by_brand_id(@good.brand_id).all
  end

  # 创建
  def create
    @good = Good.new(good_params)
    @brands = Brand.find_by_publish.all
    @goods_cate = GoodsCate.find_by_brand_id(@good.brand_id).all

    if @good.save
      redirect_to cpanel_goods_url
    else
      render :new
    end
  end

  # 修改
  def update
    @brands = Brand.find_by_publish.all
    @goods_cate = GoodsCate.find_by_brand_id(@good.brand_id).all

    if @goods_cate.length < 1
      @goods_cate = GoodsCate.find_by_brand_id(-1).all
    end

    if @good.update(good_params)
      redirect_to cpanel_goods_url
    else
      render :new
    end
  end

  # 根据专题ID获取专题下所有的分类
  def fetch_brand_cates_repositories

    # 搜索条件
    brand_id = params[:brand_id] || ''


    item = ''
    if !brand_id.blank?
      # 淘宝ID搜索商品
      item = GoodsCate.fetch_brand_cates_repositories(brand_id)
    end

    # 淘宝单品
    render json: item
  end

  # 根据淘宝ID获取商品详情
  def fetch_taobao_repositories

    # 搜索条件
    taobao_id = params[:taobao_id] || ''

    item = ''
    if !taobao_id.blank?
      # 淘宝ID搜索商品
      item = Good.fetch_taobao_repositories(taobao_id)
    end

    # 淘宝单品
    render json: item
  end


  private

    # 根据ID查询专题
    def get_good
      @good = Good.find(params[:id])
    end

    # 添加限制
    def good_params
      params[:good].permit(:taobao_id, :taobao_url, :title, :original_price, :price, :picture_url, :sort, :brand_id, :cate_id, :state)
    end
end
