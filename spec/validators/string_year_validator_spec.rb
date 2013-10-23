require 'spec_helper'

describe 'StringYearValidator' do
  let(:old_bike) { FactoryGirl.build(:bicycle, year: (Time.now.year.to_i - 200).to_s) }
  let(:good_bike) { FactoryGirl.build(:bicycle, year: (Time.now.year.to_i + 1).to_s) }
  let(:future_bike) { FactoryGirl.build(:bicycle, year: (Time.now.year.to_i + 200).to_s) }
  let(:blank_bike) { FactoryGirl.build(:bicycle, year: '') }

  it 'should be valid if the year is blank' do
    blank_bike.should be_valid
  end

  it 'should not be valid if the year is too small' do
    old_bike.should_not be_valid
  end

  it 'should not be valid if the year is too large' do
    future_bike.should_not be_valid
  end

  it 'should be valid if the year is just right' do
    good_bike.should be_valid
  end

  it 'raises an error if the provided year is too small' do
    old_bike.valid?
    old_bike.errors.full_messages.should include('The manufacturing date must be within the last 100 years')
  end

  it 'raises an error if the provided year is greater than one year in the future' do
    future_bike.valid?
    future_bike.errors.full_messages.should include('The manufacturing date must be within the last 100 years')
  end

  it 'does not raise an error if the year is the right size' do
    good_bike.valid?
    good_bike.errors.full_messages.should_not include('The manufacturing date must be within the last 100 years')
  end

  it 'does not raise an error if the year is blank' do
    blank_bike.valid?
    blank_bike.errors.full_messages.should_not include('The manufacturing date must be within the last 100 years')
  end
end
