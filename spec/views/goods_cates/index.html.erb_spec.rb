require 'rails_helper'

RSpec.describe "goods_cates/index", type: :view do
  before(:each) do
    assign(:goods_cates, [
      GoodsCate.create!(),
      GoodsCate.create!()
    ])
  end

  it "renders a list of goods_cates" do
    render
  end
end
