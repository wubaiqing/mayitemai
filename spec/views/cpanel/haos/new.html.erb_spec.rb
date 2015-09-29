require 'rails_helper'

RSpec.describe "cpanel/haos/new", type: :view do
  before(:each) do
    assign(:cpanel_hao, Cpanel::Hao.new())
  end

  it "renders new cpanel_hao form" do
    render

    assert_select "form[action=?][method=?]", cpanel_haos_path, "post" do
    end
  end
end
