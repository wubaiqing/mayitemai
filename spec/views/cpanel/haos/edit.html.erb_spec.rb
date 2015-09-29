require 'rails_helper'

RSpec.describe "cpanel/haos/edit", type: :view do
  before(:each) do
    @cpanel_hao = assign(:cpanel_hao, Cpanel::Hao.create!())
  end

  it "renders the edit cpanel_hao form" do
    render

    assert_select "form[action=?][method=?]", cpanel_hao_path(@cpanel_hao), "post" do
    end
  end
end
