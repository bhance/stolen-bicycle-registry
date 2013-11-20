require 'spec_helper'

describe "an API get request via the direct URL", :type => :api do
  it "retrieves only 'blue' bicycles from 'Dallas'" do
    FactoryGirl.create(:bicycle, color: 'blue')
    FactoryGirl.create(:bicycle, city: 'Dallas')
    2.times { FactoryGirl.create(:bicycle, city: 'Dallas', color: 'blue') }
    get "http://localhost:3000/api/v1/bicycles", { :query => { city: 'dallas', color: 'blue' }}
    json = JSON.parse(response.body)
    expect(json['bicycles'].first['city']).to eq("Dallas")
  end
end
