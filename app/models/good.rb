class Good
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :taobao_id, type: Integer, defualt: 0
  field :taobao_url
  field :title
  field :original_price
  field :price
  field :picture_url
  field :sort, type: Integer, defualt: 0
  field :brand_id, type: Integer, defualt: 0

end
