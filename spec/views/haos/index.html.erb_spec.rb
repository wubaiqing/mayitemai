require 'rails_helper'

RSpec.describe "haos/index", type: :view do
  before(:each) do
    assign(:haos, [
      Hao.create!(),
      Hao.create!()
    ])
  end

  it "renders a list of haos" do
    render
  end
end
