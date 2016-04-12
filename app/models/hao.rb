# coding: utf-8

# 商品
class Hao

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  # 必填
  validates :taobao_id, :taobao_url, :title, :price, :original_price, :picture_url, :tagid, :site, :tagid, :post, presence: true

  # 唯一
  validates :taobao_id, uniqueness: true

  # 淘宝ID
  field :taobao_id, type: Integer

  # 淘宝URL
  field :taobao_url

  # 标题
  field :title

  # 现价
  field :price

  # 原价
  field :original_price

  # 图片URL
  field :picture_url

  # site
  field :site

  # site_url
  field :site_url

  # tagid
  field :tagid, type: Integer, default: 0

  # 分类ID
  field :cate_id, type: Integer, default: 0

  # 状态
  field :state, type: Integer, default: 1

  # 包邮
  field :post , type: Integer, default: 1

  # 关联
  belongs_to :brand

  # 索引
  index state: 1
  index brand_id: 1
  index taobao_id: 1


  # 保存后更新缓存时间
  after_save :update_cache_version

  # 错误状态
  ERROR_STATE = {
    DATA_EXISTS: 10001
  }

  # 记录节点变更时间，用于清除缓存
  def update_cache_version
    CacheVersion.hao_node_updated_at = Time.now
  end

  # 集合 - 发布状态+排序值排序+ID排序
  def self.haos_collection(cate_id)
    Rails.cache.fetch("hao:hao_collection:#{cate_id}:#{CacheVersion.good_node_updated_at}") do
      if (cate_id.to_i > 0) then
        self.where(state: 1).where(tagid: cate_id.to_i).desc(:id).all
      else
        self.where(state: 1).desc(:id).all
      end
    end
  end

  # 根据淘宝ID获取淘宝信息
  def self.fetch_taobao_repositories(taobao_id, uniqueness = true)

    if uniqueness.eql?(true)
      uniqueness = self.find_by_taobao_id(taobao_id)
      if !uniqueness.blank?
        return {'errorCode': ERROR_STATE[:DATA_EXISTS]}.to_json
      end
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

  # 根据淘宝ID查询
  def self.find_by_taobao_id(taobao_id)
    where(taobao_id: taobao_id)
  end


  def self.findTag(tagid)
    @tagids = [
      "面部护理",
      "彩妆香气",
      "男士护肤",
    ]
    return @tagids[tagid.to_i - 1]
    
  end

  def self.findData(tagid, type)

    json = Hao.where(state: 1).all

    if type === 'all' && tagid.to_i === 0
      return json
    end

    tagJson = []

    if tagid.to_i > 0
      json.each do |j|
        if j["tagid"] == tagid.to_i
          tagJson.push j
        end
      end
      return tagJson
    else
      map = {
        "xiexue" => [1, 2, 3],
        "fuzhuang" => [4, 5, 6, 7],
        "meizhuang" => [8, 9],
        "shipin" => [10 ,11],
        "muying" => [12, 13],
        "jiaju" => [14, 15, 16],
        "xiangbao" => [17 ,18, 19]
      }

      if !map[type].equal?(nil)
        json.each do |j|
          if map[type].include?(j["tagid"])
            tagJson.push j
          end
        end
        return tagJson
      end
    end




  end



end



