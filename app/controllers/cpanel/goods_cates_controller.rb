class Cpanel::GoodsCatesController < Cpanel::ApplicationController

  before_action :set_goods_cate, only: [:show, :edit, :update, :destroy]

  # GET /goods_cates
  # GET /goods_cates.json
  def index
    @brands = Brand.all
    @goods_cates = GoodsCate.all
  end

  # GET /goods_cates/1
  # GET /goods_cates/1.json
  def show
  end

  # GET /goods_cates/new
  def new
    @goods_cate = GoodsCate.new
  end

  # GET /goods_cates/1/edit
  def edit
  end

  # POST /goods_cates
  # POST /goods_cates.json
  def create
    @goods_cate = GoodsCate.new(goods_cate_params)

    if @goods_cate.save
      redirect_to cpanel_goods_cates_url
    else
      render :new
    end
  end

  # PATCH/PUT /goods_cates/1
  # PATCH/PUT /goods_cates/1.json
  def update
    if @goods_cate.update(goods_cate_params)
      redirect_to cpanel_goods_cates_url
    else
      render :new
    end
  end

  # DELETE /goods_cates/1
  # DELETE /goods_cates/1.json
  def destroy
    @goods_cate.destroy
    respond_to do |format|
      format.html { redirect_to goods_cates_url, notice: 'Goods cate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goods_cate
      @goods_cate = GoodsCate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goods_cate_params
      params[:goods_cate].permit(:name, :sort, :state)
    end
end
