require 'rails_helper'

RSpec.describe "haos/show", type: :view do
  before(:each) do
    @hao = assign(:hao, Hao.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
