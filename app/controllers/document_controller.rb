# coding: utf-8

# 关于我们
class DocumentController < ApplicationController

  # 关于我们
  def about
    set_seo_meta('关于我们')
  end

  # 联系我们
  def contact
    set_seo_meta('联系我们')
  end

  # 商务合作
  def supplier
    set_seo_meta('商务合作')
  end
end
