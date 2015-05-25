require "open-uri"
class Good
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  validates :taobao_id, :taobao_url, :title, :original_price, :price, :picture_url, :sort, :brand_id, presence: true


  field :taobao_id, type: Integer
  field :taobao_url
  field :title
  field :original_price
  field :price
  field :picture_url
  field :sort, type: Integer, default: 0
  field :brand_id, type: Integer
  field :state, type: Integer, default: 1

  def self.fetch_taobao_repositories(taobao_id)

    url = "http://admin.jtzdm.com/index.php?r=goods/getgoods&taobaoId=#{taobao_id}"
    puts url
    begin
      json = Timeout::timeout(10) do
        open(url).read
      end
    rescue => e
      Rails.logger.error("Taobao Repositories fetch Error: #{e}")
      return false
    end
  end

end
