require 'spec_helper'

describe UserSerializer do
  it "creates special JSON for the API" do
    user = FactoryGirl.create(:american_user)
    serializer = UserSerializer.new user
    expect(serializer.to_json).to eq '{"user":{"first_name":"' + user.first_name + '","last_name":"Bike","country":"United States","city":"Portland","region":"OR","postal_code":"55555","phone1":"555-555-5555","phone2":"999-999-9999","email":"' + user.email + '"}}'
  end
end
