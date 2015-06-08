class HomeController < ApplicationController
  def index
    @brands = Brand.index_sort.all
    @cates = Cate.index_sort.all
  end


  def show
    @brands = Brand.find_by_cate_id(params[:id]).index_sort.all
    @cates = Cate.index_sort.all

    render "index"

  end



end
