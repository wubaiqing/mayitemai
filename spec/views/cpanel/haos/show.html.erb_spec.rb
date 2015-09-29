require 'rails_helper'

RSpec.describe "cpanel/haos/show", type: :view do
  before(:each) do
    @cpanel_hao = assign(:cpanel_hao, Cpanel::Hao.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
