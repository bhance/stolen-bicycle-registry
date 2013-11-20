require 'spec_helper'

describe API::V1::BicyclesController do
  describe "get index" do
    it 'retrieves all bicycles' do
      2.times { FactoryGirl.create(:bicycle) }
      get :index
      json = JSON.parse(response.body)
      response.status.should eql(200)
      expect(json['bicycles'].length).to eq(2)
    end

    it 'retrieves bicycles based on query' do
      FactoryGirl.create(:bicycle, city: 'Dallas')
      2.times { FactoryGirl.create(:bicycle) }

      get :index, { :query => { city: 'vancouver' } }
      json = JSON.parse(response.body)
      expect(json['bicycles'].length).to eq(2)
    end

    it "retrieves bicycles based on multiple parameters" do
      FactoryGirl.create(:bicycle, color: 'blue')
      FactoryGirl.create(:bicycle, city: 'Dallas')
      2.times { FactoryGirl.create(:bicycle, city: 'Dallas', color: 'blue') }
      get :index, { :query => { city: 'dallas', color: 'blue' } }
      json = JSON.parse(response.body)
      expect(json['bicycles'].length).to eq(2)
    end
  end

  describe "post create" do
    it "allows insertion of a bicycle to the database" do
      user = FactoryGirl.create(:canadian_user)
      bicycle_attributes = FactoryGirl.attributes_for(:bicycle, :user_id => user.id)
      post :create, bicycle: bicycle_attributes
      response.status.should eql(201)
    end

    it "responds with the created json object when a bicycle is successfully added" do
      user = FactoryGirl.create(:canadian_user)
      bicycle_attributes = FactoryGirl.attributes_for(:bicycle, :user_id => user.id)
      post :create, bicycle: bicycle_attributes
      json = JSON.parse(response.body)
      expect(json['bicycle']["description"]).to eql(bicycle_attributes[:description])
    end

    it "should fail if the request does not include all required information" do
      user = FactoryGirl.create(:canadian_user)
      bicycle_attributes = FactoryGirl.attributes_for(:bicycle, user_id: nil)
      post :create, bicycle: bicycle_attributes
      response.should_not be_success
    end

    it "includes the errors if the request fails validation" do
      user = FactoryGirl.create(:canadian_user)
      bicycle_attributes = FactoryGirl.attributes_for(:bicycle, date: nil)
      post :create, bicycle: bicycle_attributes
      json = JSON.parse(response.body)
      expect(json['user']).to eql ['can\'t be blank']
      expect(json['date']).to eql ['can\'t be blank']
    end
  end
end
