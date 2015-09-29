require 'rails_helper'

RSpec.describe "Cpanel::Haos", type: :request do
  describe "GET /cpanel_haos" do
    it "works! (now write some real specs)" do
      get cpanel_haos_path
      expect(response).to have_http_status(200)
    end
  end
end
