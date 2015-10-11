# coding: utf-8

# 商品
class Hao

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  # 必填
  validates :taobao_id, :taobao_url, :title, :price, :picture_url, :tagid, :site, :site_url, :tagid, :post, presence: true

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

  # 图片URL
  field :picture_url

  # site
  field :site

  # site_url
  field :site_url

  # tagid
  field :tagid

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
    CacheVersion.good_node_updated_at = Time.now
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
    @tagids = {
      "1" => "男鞋",
      "2" => "女鞋",
      "3" => "童鞋",
      "4" => "男装",
      "5" => "女装",
      "6" => "童装",
      "7" => "饰品",
      "8" => "彩妆",
      "9" => "护肤",
      "10" => "食品",
      "11" => "饮料",
      "12" => "妈妈",
      "13" => "宝宝",
      "14" => "家居",
      "15" => "配饰",
      "16" => "个护",
      "17" => "男包",
      "18" => "女包",
      "19" => "童包",
    }
    return @tagids[tagid]
    
  end


  def self.findData(tagid, type)

    json = Hao.all

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



