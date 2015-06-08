class DetailsController < ApplicationController

  before_action :set_detail, only: [:show]

  def show
    @goods = Good.find_by_wangwang(@brand.wangwang).desc(:id)
  end

  def destroy
    @detail.destroy
    respond_to do |format|
      format.html { redirect_to details_url, notice: 'Detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_detail
      @brand = Brand.find(params[:id])
    end
end
