class Cpanel::CatesController < Cpanel::ApplicationController
  before_action :set_cpanel_cate, only: [:show, :edit, :update, :destroy]

  # GET /cpanel/cates
  # GET /cpanel/cates.json
  def index
    @cates = Cate.all.desc(:id).paginate(:page => params[:page], :per_page => 10)

    keywords = params[:q] || ''
    if !keywords.blank?
      @cates = Cate.find_by_name(keywords)
       .desc(:id).paginate(:page => params[:page], :per_page => 10)
    end
  end

  # GET /cpanel/cates/1
  # GET /cpanel/cates/1.json
  def show
  end

  # GET /cpanel/cates/new
  def new
    @cate = Cate.new
  end

  # GET /cpanel/cates/1/edit
  def edit
  end

  # POST /cpanel/cates
  # POST /cpanel/cates.json
  def create
    @cate = Cate.new(cate_params)

    if @cate.save
      redirect_to cpanel_cates_url
    else
      render :new
    end
  end

  # PATCH/PUT /cpanel/cates/1
  # PATCH/PUT /cpanel/cates/1.json
  def update
    if @cate.update(cate_params)
      redirect_to cpanel_cates_url
    else
      render :new
    end
  end

  # DELETE /cpanel/cates/1
  # DELETE /cpanel/cates/1.json
  def destroy
    @cpanel_cate.destroy
    respond_to do |format|
      format.html { redirect_to cpanel_cates_url, notice: 'Cate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cpanel_cate
      @cate = Cate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cate_params
      params[:cate].permit(:name, :sort, :state)
    end
end
