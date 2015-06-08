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

  # 旺旺搜索
  def self.find_by_wangwang(wangwang)
    where(wangwang: /#{wangwang}/)
  end

  def self.find_by_publish
    where(state: 1).desc(:id)
  end


end
