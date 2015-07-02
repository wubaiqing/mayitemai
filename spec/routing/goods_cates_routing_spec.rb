require "rails_helper"

RSpec.describe GoodsCatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/goods_cates").to route_to("goods_cates#index")
    end

    it "routes to #new" do
      expect(:get => "/goods_cates/new").to route_to("goods_cates#new")
    end

    it "routes to #show" do
      expect(:get => "/goods_cates/1").to route_to("goods_cates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/goods_cates/1/edit").to route_to("goods_cates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/goods_cates").to route_to("goods_cates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/goods_cates/1").to route_to("goods_cates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/goods_cates/1").to route_to("goods_cates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/goods_cates/1").to route_to("goods_cates#destroy", :id => "1")
    end

  end
end
