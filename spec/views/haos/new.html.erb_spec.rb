require 'rails_helper'

RSpec.describe "haos/new", type: :view do
  before(:each) do
    assign(:hao, Hao.new())
  end

  it "renders new hao form" do
    render

    assert_select "form[action=?][method=?]", haos_path, "post" do
    end
  end
end
