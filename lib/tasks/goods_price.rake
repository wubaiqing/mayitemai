namespace :goods do
  desc "商品 - 修改价格"
  task :price do
    goods = Good.all
    goods.each do |good|
      taobaoItem = Good.fetch_taobao_repositories(good.taobao_id, false)
      
      if taobaoItem.eql?(true)
        puts taobaoItem["tbk_items_detail_get_response"]
        # good.price = 100
        # good.save()
      end


    end
  end
end
