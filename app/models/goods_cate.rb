class GoodsCate
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

   # 必填
  validates :brand_id, :name, :state, :sort, presence: true

  # 名称
  field :name

  # 专题ID
  field :brand_id, type: Integer, default: 0

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

  # 查询分类状态
  def self.find_by_publish
    where(state: 1).desc(:id)
  end

  def self.fetch_brand_cates_repositories(brand_id)
    begin
      GoodsCate.find_by_brand_id(brand_id)

    rescue => e
      Rails.logger.error("Brand Cates Repositories fetch Error: #{e}")
      return false;
    end
  end


  def self.find_by_brand_id(brand_id)
    # where(brand_id: brand_id).where(state: 1).desc(:sort).desc(:id)
    where(brand_id: brand_id).where(state: 1)
  end


end
