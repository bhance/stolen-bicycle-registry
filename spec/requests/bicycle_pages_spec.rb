require 'spec_helper'

feature 'Bicycle Registration' do

  # let(:bicycle) { FactoryGirl.create(:bicycle, user_id: @user)}

  before do
    @user = FactoryGirl.create(:american_user)
    visit new_bicycle_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
    @bicycle = FactoryGirl.create(:bicycle, user_id: @user.id)
  end

  scenario 'User fails to enter any information' do
    click_button 'Register'
    expect(page).to have_content 'blank'
  end

  scenario 'User submits information', :js => true do
    fill_in 'Theft Date', with: "01/01/2010"
    fill_in 'City', with: @bicycle.city
    select('United States', from: 'Country')
    select(@bicycle.region, from: 'State')
    fill_in 'Zip Code', with: '97214'
    fill_in 'bicycle_description', with: @bicycle.description
    click_button 'Register'
    uri = URI.parse(current_url)
    "#{uri.path}".should == "/bicycles/#{Bicycle.last.id}"
  end

  scenario 'User edits one of their bicycles', js: true do
    # @bicycle = FactoryGirl.create(:bicycle, user_id: @user.id)
    visit edit_bicycle_path(@bicycle)
    fill_in 'bicycle_color', with: 'Mauve'
    page.save_screenshot('tmp/mauve.png')
    click_button 'Register'
    page.save_screenshot('tmp/update.png')
    @bicycle.color.should eq 'Mauve'
  end

  scenario 'User edits and is redirected to the listing' do
    # @bicycle = FactoryGirl.create(:bicycle, user_id: @user.id)
    visit edit_bicycle_path(@bicycle)
    fill_in 'bicycle_color', with: 'Mauve'
    click_button 'Register'
    uri = URI.parse(current_url)
    "#{uri.path}".should == "/bicycles/#{@bicycle.id}"
  end
end