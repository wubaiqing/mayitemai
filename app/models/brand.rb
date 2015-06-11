class Brand
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  validates :cate_id, :name, :wangwang, :logo_picture, :desc_picture, :banner_picture, :sale, :sort, presence: true
  validates :wangwang, uniqueness: true

  field :cate_id, type: Integer
  field :name
  field :wangwang
  field :logo_picture
  field :desc_picture
  field :banner_picture
  field :sale
  field :sort, type: Integer, default: 0
  field :state, type: Integer, default: 1

  index({ wangwang: 1 }, { unique: true, name: "ssn_index" })
  index cate_id: 1

  STATE = {
    # 正常
    normal: 1,
    # 屏蔽
    blocked: 0
  }

  after_save :update_cache_version

  # 记录节点变更时间，用于清除缓存
  def update_cache_version
    CacheVersion.brand_node_updated_at = Time.now
  end

  # 旺旺搜索
  def self.find_by_wangwang(wangwang)
    where(wangwang: /#{wangwang}/)
  end

  # 根据发部状态查询
  def self.find_by_publish
    where(state: 1).desc(:id)
  end

  # 首页查询
  def self.index_sort
    where(state: 1).desc(:sort).desc(:id)
  end

  # 根据分类ID查询
  def self.find_by_cate_id(id)
    where(cate_id: id)
  end


  # 得到集合
  def self.brands_collection
    Rails.cache.fetch("brand:brands_collection:#{CacheVersion.brand_node_updated_at}") do
      self.index_sort.all
    end
  end

  def self.find_by_id(id)
    Rails.cache.fetch("brand:brands_collection:#{id}:#{CacheVersion.brand_node_updated_at}") do
      self.find(id)
    end
  end


end
