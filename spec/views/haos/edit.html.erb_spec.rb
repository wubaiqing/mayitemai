require 'rails_helper'

RSpec.describe "haos/edit", type: :view do
  before(:each) do
    @hao = assign(:hao, Hao.create!())
  end

  it "renders the edit hao form" do
    render

    assert_select "form[action=?][method=?]", hao_path(@hao), "post" do
    end
  end
end
