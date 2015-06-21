# coding: utf-8

# 主控制器
class Cpanel::ApplicationController < ApplicationController

  # CSRF
  protect_from_forgery with: :exception

  # 验证登录
  before_filter :require_user

  # 模板
  layout "cpanel"

  def require_user
    # 当前用户是否登陆
    if current_user.blank?
      respond_to do |format|
        format.html { authenticate_user! }
        format.all { head(:unauthorized) }
      end
    end
  end
end
