# coding: utf-8

# 商品
class Article

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  # 必填
  validates :title, :content, :picture_url, presence: true

  # 标题
  field :title

  # 状态
  field :state

  # 原价
  field :content

  # 原价
  field :picture_url

  # 索引
  index state: 1

  # 状态
  field :state, type: Integer, default: 1

  # 保存后更新缓存时间
  after_save :update_cache_version

  # 记录节点变更时间，用于清除缓存
  def update_cache_version
    CacheVersion.article_node_updated_at = Time.now
  end

  # 集合 - 发布状态+排序值排序+ID排序
  def self.articles_collection
    Rails.cache.fetch("article:article_collection:#{CacheVersion.article_node_updated_at}") do
      self.where(state: 1).desc(:id).all
    end
  end

end
