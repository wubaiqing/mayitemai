# coding: utf-8

# 配置
class Setting < Settingslogic
  source "#{Rails.root}/config/config.yml"
  namespace Rails.env
  load! if Rails.env.development?
end
