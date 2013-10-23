require 'spec_helper'

shared_examples_for Geography do
  let(:american_object) { described_class.new(:country => 'USA') }
  let(:canadian_object) { described_class.new(:country => 'Canada') }

  context 'in_us?' do
    it 'tells if an object is from the United States' do
      american_object.in_us?.should be true
    end

    it 'tells if an object is not from the United States' do
      canadian_object.in_us?.should be false
    end
  end

  describe 'in_canada?' do
    it 'tells if an object is from Canada' do
      canadian_object.in_canada?.should be true
    end

    it 'tells if an object is not from Canada' do
      american_object.in_canada?.should be false
    end
  end

  describe "address-region verification" do
    it 'ensures that the selected region is a valid Canadian province' do
      canadian_object.should ensure_inclusion_of(:region).in_array(Geography::PROVINCES)
    end
    
    it 'ensures that the selected region is a valid U.S. state' do
      american_object.should ensure_inclusion_of(:region).in_array(Geography::STATES) 
    end
  end

  describe "correct_postal_code" do      
    it 'allows postal codes of U.S. zip code format' do
      american_object.should allow_value("55555").for(:postal_code) 
    end

    it 'doesn\'t allow postals codes that are not of U.S. zip code format' do
      american_object.should_not allow_value("5555").for(:postal_code) 
    end

    it 'allows postal codes of Canadian postal code format' do
      canadian_object.should allow_value("R0J 0A0").for(:postal_code) 
    end

    it 'doesn\'t allow postals codes that are not of Canadian postal code format' do
      canadian_object.should_not allow_value("5555").for(:postal_code) 
    end
  end
end

describe User do
  it_behaves_like Geography
end

describe Bicycle do
  it_behaves_like Geography
end
