require 'spec_helper'

feature 'Bicycle Registration' do
  before do
    visit root_path
    @bicycle = FactoryGirl.create(:bicycle)
    @user = @bicycle.user
    visit sign_in_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
  end

  scenario 'User fails to enter any information' do
    visit new_bicycle_path
    click_button 'Register'
    expect(page).to have_content 'blank'
  end

  scenario 'User submits information', :js => true do
    visit new_bicycle_path
    fill_in 'datepicker', with: "01/01/2010"
    select('United States', from: 'bicycle_country' )
    select(@bicycle.region, from: 'bicycle_region')
    fill_in 'bicycle_city', with: @bicycle.city
    fill_in 'bicycle_postal_code', with: '97214'
    fill_in 'bicycle_description', with: @bicycle.description
    click_button 'Register'
    uri = URI.parse(current_url)
    "#{uri.path}".should == "/bicycles/#{Bicycle.last.id}"
  end

  scenario 'User edits one of their bicycles', js: true do
    visit edit_bicycle_path(@bicycle)
    fill_in 'bicycle_color', with: 'Mauve'
    click_button 'Register'
    Bicycle.find(@bicycle.id).color.should eq 'Mauve'
  end

  scenario 'User edits and is redirected to the listing' do
    visit edit_bicycle_path(@bicycle)
    fill_in 'bicycle_color', with: 'Mauve'
    click_button 'Register'
    uri = URI.parse(current_url)
    "#{uri.path}".should == "/bicycles/#{@bicycle.id}"
  end
end

feature 'Bicycle Search' do
  let(:bike1) { FactoryGirl.create(:bicycle) }
  let(:bike2) { FactoryGirl.create(:bicycle)}

  context 'empty searches' do
    scenario 'a user clicks basic search without a value' do
      visit search_path
      click_button 'basic-search'
      expect(page).to have_content '0 search results'
    end

    scenario 'a user clicks advanced search without any fields filled' do
      visit search_path
      click_button 'advanced-search'
      expect(page).to have_content '0 search results'
    end
  end

  context 'valid searches' do
    scenario 'a user clicks basic search with a search term' do
      visit search_path
      bike1
      bike2
      fill_in 'query', with: 'Vancouver'
      click_button 'basic-search'
      expect(page).to have_content '2 search results'
    end

    scenario 'a user clicks advanced search with some, but not all fields filled' do
      visit search_path
      bike1
      bike2
      fill_in 'query_city', with: 'Vancouver'
      fill_in 'query_color', with: 'Green'
      click_button 'advanced-search'
      expect(page).to have_content '2 search results'
    end
  end

  context 'paginated searches' do
    scenario 'a user conducts a search for recovered bicycles that exceeds one page of results' do
      visit search_path
      11.times { FactoryGirl.create(:canadian_bicycle) }
      select('Canada', from: 'query_country' )
      check 'query_recovered'
      click_button 'advanced-search'
      click_link 'Next', :match => :first
      page.should have_content '11 search results'
    end
  end
end
