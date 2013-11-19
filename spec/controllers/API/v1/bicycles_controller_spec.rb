require 'spec_helper'

describe API::V1::BicyclesController do
  describe "get index" do
    it 'retrieves all bicycles' do
      2.times { FactoryGirl.create(:bicycle) }
      get :index
      json = JSON.parse(response.body)
      response.status.should eql(200)
      expect(json.length).to eq(2)
    end

    it 'retrieves only bicycles from the city of Vancouver' do
      FactoryGirl.create(:bicycle, city: 'Dallas')
      2.times { FactoryGirl.create(:bicycle) }
      get :index, { :query => { city: 'vancouver' } }
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
    end

    it "retrieves only 'blue' bicycles from 'Dallas'" do
      FactoryGirl.create(:bicycle, color: 'blue')
      FactoryGirl.create(:bicycle, city: 'Dallas')
      2.times { FactoryGirl.create(:bicycle, city: 'Dallas', color: 'blue') }
      get :index, { :query => { city: 'dallas', color: 'blue' } }
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
    end

    it "does not return certain attributes" do
      FactoryGirl.create(:bicycle)
      get :index
      json = JSON.parse(response.body)
      json.first.should_not include(
        'approved',
        'hidden',
        'created_at',
        'updated_at',
        'photo_file_name',
        'photo_content_type',
        'photo_file_size',
        'photo_updated_at',
        'verified_ownership',
        'user_id'
        )
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
      expect(json["description"]).to eql(bicycle_attributes[:description])
    end

    it "should have only allowed attributes in the response object" do
      user = FactoryGirl.create(:canadian_user)
      bicycle_attributes = FactoryGirl.attributes_for(:bicycle, :user_id => user.id)
      post :create, bicycle: bicycle_attributes
      json = JSON.parse(response.body)
      json.should_not have_key(:created_at)
    end

    it "should fail if the request does not include all required information" do
      user = FactoryGirl.create(:canadian_user)
      bicycle_attributes = FactoryGirl.attributes_for(:bicycle)
      post :create, bicycle: bicycle_attributes
      response.should_not be_success
    end
  end
end
