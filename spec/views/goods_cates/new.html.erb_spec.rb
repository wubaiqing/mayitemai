require 'rails_helper'

RSpec.describe "goods_cates/new", type: :view do
  before(:each) do
    assign(:goods_cate, GoodsCate.new())
  end

  it "renders new goods_cate form" do
    render

    assert_select "form[action=?][method=?]", goods_cates_path, "post" do
    end
  end
end
