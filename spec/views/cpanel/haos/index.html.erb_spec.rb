require 'rails_helper'

RSpec.describe "cpanel/haos/index", type: :view do
  before(:each) do
    assign(:cpanel_haos, [
      Cpanel::Hao.create!(),
      Cpanel::Hao.create!()
    ])
  end

  it "renders a list of cpanel/haos" do
    render
  end
end
