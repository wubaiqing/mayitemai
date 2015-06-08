class HomeController < ApplicationController
  def index
    @brand = Brand.all
  end

  private


end
