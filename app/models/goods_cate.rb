class GoodsCate
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

   # 必填
  validates :name, :state, :sort, presence: true

  # 唯一
  # validates :name, uniqueness: true

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

end
