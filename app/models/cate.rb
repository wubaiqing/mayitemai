# coding: utf-8

# 分类
class Cate
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  # 必填
  validates :name, :state, :sort, presence: true

  # 唯一
  validates :name, uniqueness: true

  # 名称
  field :name

  # 排序
  field :sort, type: Integer, default: 0

  # 状态
  field :state, type: Integer, default: 1

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
    CacheVersion.cate_node_updated_at = Time.now
  end

  # 查询分类名称
  def self.find_by_name(name)
    where(name: /#{name}/)
  end

  # 查询分类状态
  def self.find_by_publish
    where(state: 1).desc(:id)
  end

  # 首页 - 搜索条件
  def self.index_sort
    where(state: 1).desc(:sort).asc(:id)
  end

  # 首页 - 缓存搜索
  def self.cate_collections
    Rails.cache.fetch("cate:cate_collections:#{CacheVersion.update_cache_version}") do
      self.index_sort.all
    end
  end

end
