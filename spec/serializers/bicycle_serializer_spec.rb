require 'spec_helper'

describe BicycleSerializer do
  it "creates special JSON for the API" do
    bicycle = FactoryGirl.create(:bicycle)
    serializer = BicycleSerializer.new bicycle
    expect(serializer.to_json).to eq '{"bicycle":{"date":"2011-03-05","city":"Vancouver","region":"WA","postal_code":"97212","serial":"' + bicycle.serial + '","police_report":"' + bicycle.police_report + '","description":"This is my bike. It was stolen on Wednesday, by the parking lot of Walmart at 82nd. There is a death to bike thieves sticker on it. Please help!","reward":100,"brand":"Rivendell","model":"Aquarius","color":"Seafoam Green","size":54,"size_type":"cm","country":"United States","user_id":' + bicycle.user_id.to_s + ',"year":2002}}'
  end
end
