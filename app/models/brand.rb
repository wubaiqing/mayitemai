class Brand
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  validates :name, :wangwang, :banner_picture, :recommend_picture, presence: true

  field :name
  field :wangwang
  field :banner_picture
  field :recommend_picture
  field :state, type: Integer, default: 0

  def attributes
    { 'name' => @name }
  end

  STATE = {
    # 软删除
    deleted: -1,
    # 正常
    normal: 1,
    # 屏蔽
    blocked: 2,
  }

  def attributes
    { 'name' => @name }
  end

  before_save :auto_set_value
  def auto_set_value
    
  end

end
