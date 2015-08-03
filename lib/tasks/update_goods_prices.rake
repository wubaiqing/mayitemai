namespace :update_goods_prices do
	desc "批量修改商品价格"
	task :nothing => :environment do
		goods = Good.where(state: 1).desc(:id).all

		taobao_ids = {}
		goods.each do |good|
			b = taobao_ids[good.taobao_id % 99]
			b.push good.taobao_id
		end
		puts taobao_ids


	end
end
