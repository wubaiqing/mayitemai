class DetailsController < ApplicationController

  before_action :set_detail, only: [:show]

  def show
    @goods = Good.good_collection(@brand.id, @brand.wangwang)
  end

  private
    def set_detail
      @brand = Brand.find_by_id(params[:id])
    end
end
