require 'spec_helper'

describe API::V1::UsersController do
  describe "post create" do
    it "allows insertion of a user to the database" do
      user_attributes = FactoryGirl.attributes_for(:canadian_user)
      post :create, user: user_attributes
      response.status.should eq 201
    end

    it "allows insertion of a bicycle through nested attributes" do
      user_attributes = FactoryGirl.attributes_for(:canadian_user)
      user_attributes[:bicycles_attributes] = [FactoryGirl.attributes_for(:canadian_bicycle)]
      post(:create, user: user_attributes)
      Bicycle.count.should eq 1
    end
  end

  it "responds with the created json object when a user is successfully added" do
    user_attributes = FactoryGirl.attributes_for(:canadian_user)
    post :create, user: user_attributes
    json = JSON.parse(response.body)
    json['user']['first_name'].should eql(user_attributes[:first_name])
  end

  it "should have only allowed attributes in the response object" do
    user_attributes = FactoryGirl.attributes_for(:canadian_user)
    post :create, user: user_attributes
    json = JSON.parse(response.body)
    json.should_not have_key(:created_at)
  end

  it "should fail if the request does not include all required information" do
    user_attributes = {:first_name=>"Joe"}
    post :create, user: user_attributes
    response.should_not be_success
  end
end

