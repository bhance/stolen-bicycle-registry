require 'spec_helper'

feature 'Bicycle Registration' do

  # let(:bicycle) { FactoryGirl.create(:bicycle, user_id: @user)}

  before do
    @user = FactoryGirl.create(:american_user)
    @bicycle = FactoryGirl.create(:bicycle, user_id: @user.id)
    visit new_bicycle_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
  end

  scenario 'User fails to enter any information' do
    click_button 'Register'
    expect(page).to have_content 'blank'
  end

  scenario 'User submits information', :js => true do
    fill_in 'Theft Date', with: "01/01/2010"
    select('United States', from: 'Country')
    select(@bicycle.region, from: 'State')
    fill_in 'City', with: @bicycle.city
    fill_in 'Zip Code', with: '97214'
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
  let(:bike2) { FactoryGirl.create(:bicycle) }

  scenario 'a user clicks basic search without a value' do
    visit search_path
    click_button 'basic-search'
    expect(page).to_not have_content 'search result'   
  end

  scenario 'a user clicks basic search with a search term' do
    visit search_path
    bike1
    bike2
    fill_in 'query', with: 'Vancouver'
    click_button 'basic-search'
    expect(page).to have_content '2 search results'  
  end

  scenario 'a user clicks advanced search without any fields filled' do
    visit search_path
    click_button 'advanced-search'
    expect(page).to_not have_content 'search result'
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