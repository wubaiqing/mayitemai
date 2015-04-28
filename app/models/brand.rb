class Brand
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  validates :name, :wangwang, :banner_picture, :recommend_picture, presence: true

  field :name
  field :wangwang
  field :banner_picture
  field :recommend_picture
  field :state, type: Integer, default: 1

  STATE = {
    # 正常
    normal: 1,
    # 屏蔽
    blocked: 0
  }
  

end
