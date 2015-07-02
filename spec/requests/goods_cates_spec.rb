require 'rails_helper'

RSpec.describe "GoodsCates", type: :request do
  describe "GET /goods_cates" do
    it "works! (now write some real specs)" do
      get goods_cates_path
      expect(response).to have_http_status(200)
    end
  end
end
