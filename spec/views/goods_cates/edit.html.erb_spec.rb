require 'rails_helper'

RSpec.describe "goods_cates/edit", type: :view do
  before(:each) do
    @goods_cate = assign(:goods_cate, GoodsCate.create!())
  end

  it "renders the edit goods_cate form" do
    render

    assert_select "form[action=?][method=?]", goods_cate_path(@goods_cate), "post" do
    end
  end
end
