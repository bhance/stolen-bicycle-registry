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
                        'AB', 'BC', 'MB', 'NB', 'NL', 
                        'NS', 'NT', 'NU', 'ON', 'PE', 
                        'QC', 'SK', 'YT']

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
  # it { should validate_numericality_of :year }

  it "should save user input year as a string" do
    bike1 = FactoryGirl.create(:bicycle)
    bike1.reload
    bike1.year.class.name.should eq 'String'
  end
end

describe "Bicycle search" do

  before do
    @bike1 = FactoryGirl.create(:bicycle)
    @bike2 = FactoryGirl.create(:bicycle, model: 'Vancouver', color: 'Mauve')
  end

  it "basic search should not return results given an empty search string" do
    query = ''
    Bicycle.bicycle_search(query).should eq nil
  end

  it "basic search should return search results given a search string" do
    query = 'Vancouver'
    Bicycle.bicycle_search(query).length.should eq 2
  end

  it "advanced search should return nil when given all empty fields" do
    query = { model: '' }
    Bicycle.bicycle_search(query).should eq nil
  end

  it "advanced search should return search results given an empty field" do
    query = { model: '', color: 'Mauve' }
    Bicycle.bicycle_search(query).last.should eq @bike2
  end

  it "search results should not include bike listings that are currently hidden by a user/admin" do
    @bike2.update(hidden: true )
    query = 'Vancouver'
    Bicycle.bicycle_search(query).length.should eq 1
  end

  it "basic/advanced search results include only unrecovered listings by default" do
    @bike2.update(recovered: true)
    query = 'Vancouver'
    Bicycle.bicycle_search(query).should eq [@bike1]
  end

  it "search results should include found listings when 'include found' is checked" do
    @bike2.update(recovered: true)
    query = { city: 'Vancouver', 'recovered' => '1' }
    Bicycle.bicycle_search(query).length.should eq 2
  end
end

