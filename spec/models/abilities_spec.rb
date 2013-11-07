require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  context 'admin' do
    it 'should be able to destroy another user' do
      admin = FactoryGirl.create(:admin)
      ability = Ability.new(admin)
      user = FactoryGirl.create(:american_user)
      ability.should be_able_to(:destroy, user)
    end

    it 'should be able to update a bike listing' do
      admin = FactoryGirl.create(:admin)
      ability = Ability.new(admin)
      user = FactoryGirl.create(:american_user)
      bicycle = FactoryGirl.create(:bicycle)
      ability.should be_able_to(:update, bicycle)
    end
  end

  context 'user' do
    it 'should not be able to approve a listing' do
      user = FactoryGirl.create(:american_user)
      ability = Ability.new(user)
      bicycle = FactoryGirl.create(:bicycle)
      bicycle.approved = true
      ability.should_not be_able_to(:update, bicycle)
    end

    it 'should be able to update other parts of the listing' do
      user = FactoryGirl.create(:american_user)
      ability = Ability.new(user)
      bicycle = FactoryGirl.create(:bicycle)
      bicycle.color = 'blue'
      ability.should be_able_to(:update, bicycle)
    end
  end
end
