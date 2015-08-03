namespace :update_goods_prices do
	desc "批量修改商品价格"
	task :nothing => :environment do
		goods = Good.where(state: 1).desc(:id).all

		goods.each_with_index do |good, index|
			puts index % 42
		end
	


	end
end
