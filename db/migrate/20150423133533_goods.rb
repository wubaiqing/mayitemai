class Goods < ActiveRecord::Migration
  def change
    create_table "goods", :force => true do |t|

      t.integer  "taobao_id",           :default => 0,     :null => false
      t.string   "taobao_url",                             :null => false
      t.string   "title",                                  :null => false
      t.integer  "price",               :default => 0,     :null => false
      t.integer  "taobao_price",        :default => 0,     :null => false
      t.string   "picutre_url",                            :null => false
      t.integer  "sort",                :default => 0,     :null => false
      t.integer  "brand_id",            :default => 0,     :null => false
      t.timestamps

      t.index [:taobao_id, :brand_id]
    end
  end
end
