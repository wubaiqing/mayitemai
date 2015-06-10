class DetailsController < ApplicationController

  before_action :set_detail, only: [:show]

  def show
    @goods = Good.find_by_wangwang(@brand.wangwang).desc(:id)
  end

  private
    def set_detail
      @brand = Brand.find(params[:id])
    end
end
