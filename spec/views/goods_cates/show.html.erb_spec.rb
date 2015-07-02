require 'rails_helper'

RSpec.describe "goods_cates/show", type: :view do
  before(:each) do
    @goods_cate = assign(:goods_cate, GoodsCate.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
