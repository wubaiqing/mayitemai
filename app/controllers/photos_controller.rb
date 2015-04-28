class PhotosController < ApplicationController

  def create
    put_policy = Qiniu::Auth::PutPolicy.new("mayitemai")
    # 浮动窗口上传
    params[:Filedata]
    render text: 1
  end
end
