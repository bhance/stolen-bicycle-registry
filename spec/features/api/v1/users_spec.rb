require "spec_helper"

  describe "an API post request via the direct URL", :type => :api do
    it "allows insertion of a user to the database" do
      user_attributes = FactoryGirl.attributes_for(:canadian_user)
      post "http://localhost:3000/api/v1/users", { :user => user_attributes }
      json = JSON.parse(response.body)
      expect(json["city"]).to eq("Toronto")
    end
  end

