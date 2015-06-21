class Cpanel::CatesController < Cpanel::ApplicationController

  before_action :get_cate, only: [:edit, :update]

  # 管理
  def index

    # 翻页
    @cates = Cate.all.desc(:id).paginate(:page => params[:page], :per_page => 10)

    # 搜索条件
    keywords = params[:q] || ''

    if !keywords.blank?
      # 名称搜索
      @cates = Cate.find_by_name(keywords)
       .desc(:id).paginate(:page => params[:page], :per_page => 10)
    end
  end

  # 新建
  def new
    @cate = Cate.new
  end

  # 创建
  def create
    @cate = Cate.new(cate_params)

    if @cate.save
      redirect_to cpanel_cates_url
    else
      render :new
    end
  end

  # 修改
  def update
    if @cate.update(cate_params)
      redirect_to cpanel_cates_url
    else
      render :new
    end
  end


  private

    # 根据ID查询分类
    def get_cate
      @cate = Cate.find(params[:id])
    end

    # 添加限制
    def cate_params
      params[:cate].permit(:name, :sort, :state)
    end
end
