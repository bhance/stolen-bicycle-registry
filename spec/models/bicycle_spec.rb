require 'spec_helper'

state_abbreviations =  ['AL', 'AK', 'AZ', 'AR', 'CA', 
                        'CO', 'CT', 'DE', 'FL', 'GA', 
                        'HI', 'ID', 'IL', 'IN', 'IA', 
                        'KS', 'KY', 'LA', 'ME', 'MD', 
                        'MA', 'MI', 'MN', 'MS', 'MO', 
                        'MT', 'NE', 'NV', 'NH', 'NJ', 
                        'NM', 'NY', 'NC', 'ND', 'OH', 
                        'OK', 'OR', 'PA', 'RI', 'SC',
                        'SD', 'TN', 'TX', 'UT', 'VT', 
                        'VA', 'WA', 'WV', 'WI', 'WY', 
                        'AS', 'DC', 'FM', 'GU', 'MH', 
                        'MP', 'PW', 'PR', 'VI', 'AA', 
                        'AE', 'AP']

describe Bicycle do
  it { should belong_to :user }
  it { should validate_presence_of :date }
  it { should validate_presence_of :country }
  it { should validate_presence_of :region }
  it { should validate_presence_of :city }
  it { should validate_presence_of :description }
  it { should ensure_inclusion_of(:region).in_array(state_abbreviations) }
  it { should ensure_inclusion_of(:size_type).in_array(['cm', 'in']) }
  it { should validate_uniqueness_of :serial }
  it { should ensure_length_of(:description).
              is_at_least(30).
              is_at_most(2000) }
  it { should validate_numericality_of :year }

  describe 'When posting from Canada' do
  end

  describe 'When posting from the US' do
  end

  describe "Bicycle search" do
    it "should return 'nil' given no search string" do
      FactoryGirl.create(:bicycle)
      query = nil
      Bicycle.bicycle_search(query).should eq nil
    end

    it "should return search results given a search string" do
      FactoryGirl.create(:bicycle)
      FactoryGirl.create(:bicycle, model: 'Vancouver')
      query = 'Vancouver'
      Bicycle.bicycle_search(query).length.should eq 2
    end

    it "should return search results given an empty field" do
      bike1 = FactoryGirl.create(:bicycle)
      bike2 = FactoryGirl.create(:bicycle, model: 'Vancouver', color: 'Mauve')
      query = { model: '', color: 'Mauve' }
      Bicycle.bicycle_search(query).last.should eq bike2
    end
  end
end

