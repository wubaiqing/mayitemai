require 'rails_helper'

RSpec.describe "Haos", type: :request do
  describe "GET /haos" do
    it "works! (now write some real specs)" do
      get haos_path
      expect(response).to have_http_status(200)
    end
  end
end
