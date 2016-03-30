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

  private

    # 根据ID查询专题
    def get_article
      @good = Good.find(params[:id])
    end

    # 添加限制
    def article_params
      params[:article].permit(:title, :content)
    end
end
