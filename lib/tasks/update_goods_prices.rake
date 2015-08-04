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

      item = items["tbk_items_detail_get_response"]["tbk_items"]["tbk_item"].to_a
      if item[0] == nil
        next
      end

      model = Good.find good.id
      oldPrice = model.price.to_f

      # 修改价格
      discount_price = item[0]["discount_price"].to_s
      if discount_price[-2] == "0"
        price = discount_price.to_i
      else
        price = discount_price.to_f
      end

      # 当前价格和老价格比较
      if oldPrice == price
        next
      end
      
      model.price = price
      model.save
      puts model.errors.messages

    end

  end
end
