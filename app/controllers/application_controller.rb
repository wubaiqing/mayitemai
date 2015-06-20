# coding: utf-8

# 应用控制器
class ApplicationController < ActionController::Base

  # CSRF
  protect_from_forgery with: :exception

  # 设置meta方法
  def set_seo_meta(title = '', meta_keywords = '', meta_description = '')
    @page_title = "#{title}" if title.length > 0
    @meta_keywords = meta_keywords
    @meta_description = meta_description
  end
end
