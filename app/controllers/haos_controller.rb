class HaosController < ApplicationController

  # GET /haos
  # GET /haos.json
  def index
    tag = params[:tag] || 'all'
    @haos = Hao.findData(tag)
  end

  # GET /haos/1
  # GET /haos/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hao
      @hao = Hao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hao_params
      params[:hao]
    end
end
