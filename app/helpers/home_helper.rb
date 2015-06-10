module HomeHelper
  def cache_key_for_goods
    count          = Good.count
    "goods/all-#{count}"
  end
end
