# coding: utf-8

# 商品
class Article

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  # 必填
  validates :title, :content, presence: true

  # 标题
  field :title

  # 状态
  field :state

  # 原价
  field :content

  # 索引
  index state: 1

  # 保存后更新缓存时间
  after_save :update_cache_version

  # 记录节点变更时间，用于清除缓存
  def update_cache_version
    CacheVersion.article_node_updated_at = Time.now
  end

end
