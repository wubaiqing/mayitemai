class HaosController < ApplicationController

  # GET /haos
  # GET /haos.json
  def index
    tagid = params[:tagid] || 'all'
    type = params[:type] || nil
    @haos = Hao.findData(tagid, type)
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
