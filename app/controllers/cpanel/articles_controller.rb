# coding: utf-8

# 商品管理
class Cpanel::ArticlesController < Cpanel::ApplicationController

  before_action :get_article, only: [:edit, :update]

  # 管理
  def index

    # 翻页
    @articles = Article.all.desc(:id).paginate(:page => params[:page], :per_page => 10)

  end

  # 新增
  def new
    @article = Article.new
  end

  # 编辑
  def edit
    @brands = Brand.find_by_publish.all
  end

  # 创建
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to cpanel_articles_url
    else
      render :new
    end
  end

  # 修改
  def update

    if @article.update(article_params)
      redirect_to cpanel_articles_url
    else
      render :new
    end
  end

  private

    # 根据ID查询专题
    def get_article
      @article = Article.find(params[:id])
    end

    # 添加限制
    def article_params
      params[:article].permit(:title, :content)
    end
end
