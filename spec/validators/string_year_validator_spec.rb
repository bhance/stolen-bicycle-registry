require 'spec_helper'

describe 'StringYearValidator' do

  before do
    @old_bike = FactoryGirl.build(:bicycle, year: '1000')
    @good_bike = FactoryGirl.build(:bicycle, year: '1988')
    @future_bike = FactoryGirl.build(:bicycle, year: '3000')
  end

  it 'should not be valid if the year is too small' do
    @old_bike.should_not be_valid
  end

  it 'should not be valid if the year is too large' do
    @future_bike.should_not be_valid
  end

  it 'should be valid if the year is just right' do
    @good_bike.should be_valid
  end

  it 'raises an error if the provided year is too small' do
    @old_bike.valid?
    @old_bike.errors.full_messages.should include("The year must be within 100 years before today")
  end

  it 'raises an error if the provided tear is too large' do
    @future_bike.valid?
    @future_bike.errors.full_messages.should include("The year must be within 100 years before today")
  end

  it 'does not raise an error if the year is the right size' do
    @good_bike.valid?
    @good_bike.errors.full_messages.should_not include("The year must be within 100 years before today")
  end
end