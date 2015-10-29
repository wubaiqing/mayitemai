namespace :goods do
  desc "Fix goods price"
  task price: :environment do

    # 获取所有在线的商品
    goods = Good.where(state: 1).desc(:id).all

    # 每天记录日志
    logger = Logger.new('./log/task.log', 'daily')
    logger.level = Logger::INFO

    goods.each do |good|

      # 非淘宝商品
      if good.taobao_id.nil?
        next
      end

      # 第三方API获取
      items = Good.fetch_taobao_repositories good.taobao_id, false
      if items["tbk_items_detail_get_response"]["total_results"] == 0
        next
      end

      item = items["tbk_items_detail_get_response"]["tbk_items"]["tbk_item"].to_a
      if item[0].nil?
        next
      end

      # 修改价格
      discount_price = item[0]["discount_price"].to_s
      if discount_price[-2] == "0"
        oldPrice = good.price.to_i
        price = discount_price.to_i
      else
        oldPrice = good.price.to_f
        price = discount_price.to_f
      end

      # 修改价格
      discount_price = item[0]["discount_price"].to_s
      if discount_price[-2] == "0"
        oldPrice = good.price.to_i
        price = discount_price.to_i
      else
        oldPrice = good.price.to_f
        price = discount_price.to_f
      end

      # 修改价格
      original_price = item[0]["price"].to_s
      if original_price[-2] == "0"
        original_price = original_price.to_i
      else
        original_price = original_price.to_f
      end

      # 当前价格和老价格比较
      # if oldPrice == price
      #   logger.info("跳过修改价格。ID：#{good.id}，之前价格#{oldPrice}，现在价格#{price}")
      #   next
      # end

      good.update_attribute(:price, price)
      good.update_attribute(:original_price , original_price)
      logger.info("商品ID：#{good.id}，之前价格#{oldPrice}，现在价格#{price}，错误提示#{good.errors.messages}")

    end

  end
end

