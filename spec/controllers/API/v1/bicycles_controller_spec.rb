require 'spec_helper'

describe API::V1::BicyclesController do
  it 'retrieves all bicycles' do
    2.times { FactoryGirl.create(:bicycle) }
    get :index
    json = JSON.parse(response.body)
    expect(response).to be_success
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

  # it "allows insertion of a new user/bike into the database" do
  #   bicycle = FactoryGirl.create(:bicycle).to_json
  #   post :create, bicycle
  #   json = JSON.parse(response.body)
  #   json.should equal "user and bike created"
  #   expect(json).to eq("user and bike created")
  # end
end
