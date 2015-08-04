namespace :update_goods_prices do
  desc "批量修改商品价格"
  task :nothing => :environment do
    # 获取所有在线的商品
    goods = Good.where(state: 1).desc(:id).all

    # 获取所有的淘宝ID
    taobao_ids = []

    # 循环所有商品
    goods.each do |good|
      if good.taobao_id == nil
        next
      end

      items = Good.fetch_taobao_repositories good.taobao_id, false
      if items["tbk_items_detail_get_response"]["total_results"] == 0
        next
      end


      price = items["tbk_items_detail_get_response"]["tbk_items"]["tbk_item"]
      puts price

    end

  end
end
