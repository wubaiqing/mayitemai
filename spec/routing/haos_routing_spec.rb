require "rails_helper"

RSpec.describe HaosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/haos").to route_to("haos#index")
    end

    it "routes to #new" do
      expect(:get => "/haos/new").to route_to("haos#new")
    end

    it "routes to #show" do
      expect(:get => "/haos/1").to route_to("haos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/haos/1/edit").to route_to("haos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/haos").to route_to("haos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/haos/1").to route_to("haos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/haos/1").to route_to("haos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/haos/1").to route_to("haos#destroy", :id => "1")
    end

  end
end
