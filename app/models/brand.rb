# coding: utf-8

# 专题
class Brand

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  # 必填
  validates :cate_id, :name, :wangwang, :logo_picture, :desc_picture, :banner_picture, :sale, :sort, presence: true

  # 唯一
  validates :wangwang, uniqueness: true

  # 分类ID
  field :cate_id, type: Integer

  # 名称
  field :name

  # 旺旺
  field :wangwang

  # Logo
  field :logo_picture

  # 首页图片
  field :desc_picture

  # Banner
  field :banner_picture

  # 折扣
  field :sale

  # 排序
  field :sort, type: Integer, default: 0

  # 状态
  field :state, type: Integer, default: 1

  # 旺旺名称索引
  index({ wangwang: 1 }, { unique: true, name: "ssn_index" })

  # 分类ID索引
  index cate_id: 1

  # 状态
  STATE = {
    # 正常
    normal: 1,
    # 屏蔽
    blocked: 0
  }

  # 保存后更新缓存时间
  after_save :update_cache_version

  # 记录节点变更时间，用于清空缓存
  def update_cache_version
    CacheVersion.brand_node_updated_at = Time.now
  end

  # 条件 - 旺旺搜索
  def self.find_by_wangwang(wangwang)
    where(wangwang: /#{wangwang}/)
  end

  # 条件 - 发布状态
  def self.find_by_publish
    where(state: 1).desc(:id)
  end

  # 条件 - 分类ID
  def self.find_by_cate_id(id)
    where(id: id)
  end

  # 集合 - 发布状态+排序值排序+ID排序
  def self.brands_collection
    Rails.cache.fetch("brand:brands_collection:#{CacheVersion.brand_node_updated_at}") do
      self.where(state: 1).desc(:sort).desc(:id).all
    end
  end

  # 集合 - 当前专题
  def self.find_by_id(id)
    Rails.cache.fetch("brand:brands_collection:#{id}:#{CacheVersion.brand_node_updated_at}") do
      self.find(id)
    end
  end

end
