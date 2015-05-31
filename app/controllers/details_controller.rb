class DetailsController < ApplicationController

  before_action :set_detail, only: [:show]

  # GET /details/1
  # GET /details/1.json
  def show
    @goods = Good.find_by_wangwang(@brand.wangwang)
  end

  # DELETE /details/1
  # DELETE /details/1.json
  def destroy
    @detail.destroy
    respond_to do |format|
      format.html { redirect_to details_url, notice: 'Detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detail
      @brand = Brand.find(params[:id])
    end
end
