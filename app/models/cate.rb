class Cate
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  validates :name, :state, :sort, presence: true
  validates :name, uniqueness: true

  field :name
  field :sort, type: Integer, default: 0
  field :state, type: Integer, default: 1

  STATE = {
    # 正常
    normal: 1,
    # 屏蔽
    blocked: 0
  }

  def self.find_by_name(name)
    where(name: /#{name}/)
  end

  def self.find_by_publish
    where(state: 1).desc(:id)
  end

  def self.index_sort
    where(state: 1).desc(:sort).desc(:id)
  end






end
