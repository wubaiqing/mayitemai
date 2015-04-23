class Brand < ActiveRecord::Migration
  def change
    create_table "brand", :force => true do |t|

      t.string   "name",                                 :null => false
      t.string   "wangwang",                             :null => false
      t.string   "branner_picutre",                      :null => false
      t.string   "recommend_picutre",                    :null => false
      t.string   "status",                               :null => false
      t.timestamps

      t.index [:status]
    end
  end
end
