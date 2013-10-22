require 'spec_helper'

describe Bicycle do
  it { should validate_presence_of :user_id }
  it { should belong_to :user }
  it { should validate_presence_of :date }
  it { should validate_presence_of :country }
  it { should validate_presence_of :region }
  it { should validate_presence_of :city }
  it { should validate_presence_of :description }
  it { should ensure_inclusion_of(:region).in_array(Geography::STATES) }
  it { should ensure_inclusion_of(:size_type).in_array(['cm', 'in']) }
  it { should validate_uniqueness_of :serial }
  it { should ensure_length_of(:description).is_at_least(30).
                                             is_at_most(2000) }

  it "should save user input year as a string" do
    bike1 = FactoryGirl.create(:bicycle, year: 2002)
    bike1.reload
    bike1.year.should eq '2002'
  end

  describe ".flexible_search" do
    before do
      @bike1 = FactoryGirl.create(:bicycle)
      @bike2 = FactoryGirl.create(:bicycle, model: 'Vancouver', color: 'Mauve')
    end

    it "basic search should not return results given an empty search string" do
      query = ''
      Bicycle.flexible_search(query).should eq Bicycle.none
    end

    it "basic search should return search results given a search string" do
      query = 'Vancouver'
      Bicycle.flexible_search(query).should match_array [@bike1, @bike2]
    end

    it "advanced search should return nil when given all empty fields" do
      query = { model: '' }
      Bicycle.flexible_search(query).should eq Bicycle.none
    end

    it "advanced search should return search results given an empty field" do
      query = { model: '', color: 'Mauve' }
      Bicycle.flexible_search(query).should eq [@bike2]
    end

    it "search results should not include bike listings that are currently
        hidden by a user/admin" do
      @bike2.update(hidden: true )
      query = 'Vancouver'
      Bicycle.flexible_search(query).should eq [@bike1]
    end

    it "basic/advanced search results include only unrecovered listings by
      default" do
      @bike2.update(recovered: true)
      query = 'Vancouver'
      Bicycle.flexible_search(query).should eq [@bike1]
    end

    it "search results should include found listings when 'include found' is
      checked" do
      @bike2.update(recovered: true)
      query = HashWithIndifferentAccess.new({ city: 'Vancouver', recovered: '1' })
      Bicycle.flexible_search(query).should match_array [@bike1, @bike2]
    end
  end
end
