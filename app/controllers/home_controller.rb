class HomeController < ApplicationController
  def index
    @brands = Brand.brands_collection
    @cates = Cate.cate_collections
  end


  def show
    @brands = Brand.find_by_cate_id(params[:id]).index_sort.all
    @cates = Cate.cate_collections
    render "index"
  end

end
