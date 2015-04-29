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

    respond_to do |format|
      if @good.save
        format.html { redirect_to @good, notice: 'Good was successfully created.' }
        format.json { render :show, status: :created, location: @good }
      else
        format.html { render :new }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # 修改
  def update
    respond_to do |format|
      if @good.update(good_params)
        format.html { redirect_to @good, notice: 'Good was successfully updated.' }
        format.json { render :show, status: :ok, location: @good }
      else
        format.html { render :edit }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
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
