class Brand
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  validates :name, presence: true

  field :name
  field :wangwang
  field :banner_picture
  field :recommend_picture
  field :publish, type: Mongoid::Boolean, default: false

  before_save :auto_set_value
  def auto_set_value
    
  end

end
