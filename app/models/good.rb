require "open-uri"

class Good
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  validates :taobao_id, :taobao_url, :title, :original_price, :price, :picture_url, :sort, :brand_id, presence: true
  validates :taobao_id, uniqueness: true

  field :taobao_id, type: Integer
  field :taobao_url
  field :title
  field :original_price
  field :price
  field :picture_url
  field :sort, type: Integer, default: 0
  field :brand_id, type: Integer
  field :state, type: Integer, default: 1

  belongs_to :brand

  index state: 1
  index brand_id: 1
  index taobao_id: 1

  after_save :update_cache_version


  # 没有数据
  ERROR_STATE = {
    DATA_EXISTS: 10001
  }

  # 记录节点变更时间，用于清除缓存
  def update_cache_version
    CacheVersion.good_node_updated_at = Time.now
  end


  # 根据淘宝ID获取淘宝信息
  def self.fetch_taobao_repositories(taobao_id)

    uniqueness = self.find_by_taobao_id(taobao_id)
    if !uniqueness.blank?
      return {'errorCode': ERROR_STATE[:DATA_EXISTS]}.to_json
    end

    begin
      hash = OpenTaobao.get(
        :method => "taobao.tbk.items.detail.get",
        :fields => "num_iid,seller_id,nick,title,price,volume,pic_url,item_url,shop_url",
        :num_iids => taobao_id
      )
    rescue => e
      Rails.logger.error("Taobao Repositories fetch Error: #{e}")
      return false
    end
  end


  # 根据旺旺名称查询
  def self.find_by_wangwang(wangwang)
    ids = Brand.where(wangwang: /#{wangwang}/).pluck(:id)
    where(:brand_id.in => ids)
  end


  # 根据淘宝ID查询
  def self.find_by_taobao_id(taobao_id)
    where(taobao_id: taobao_id)
  end


   # 得到集合
  def self.good_collection(id, wangwang)
    Rails.cache.fetch("good:good_collection:#{id}:#{CacheVersion.good_node_updated_at}") do
      self.find_by_wangwang(wangwang).desc(:sort).desc(:id).all
    end
  end




end
