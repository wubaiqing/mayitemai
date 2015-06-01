class DocumentController < ApplicationController
  def about
    set_seo_meta('关于我们')
  end

  def contact
    set_seo_meta('联系我们')
  end

  def supplier
    set_seo_meta('商务合作')
  end
end
