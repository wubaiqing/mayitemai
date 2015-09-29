require "rails_helper"

RSpec.describe Cpanel::HaosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cpanel/haos").to route_to("cpanel/haos#index")
    end

    it "routes to #new" do
      expect(:get => "/cpanel/haos/new").to route_to("cpanel/haos#new")
    end

    it "routes to #show" do
      expect(:get => "/cpanel/haos/1").to route_to("cpanel/haos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cpanel/haos/1/edit").to route_to("cpanel/haos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cpanel/haos").to route_to("cpanel/haos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cpanel/haos/1").to route_to("cpanel/haos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cpanel/haos/1").to route_to("cpanel/haos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cpanel/haos/1").to route_to("cpanel/haos#destroy", :id => "1")
    end

  end
end
