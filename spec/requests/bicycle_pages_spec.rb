require 'spec_helper'

feature 'Bicycle Registration' do

  let(:bicycle) { FactoryGirl.build(:bicycle)}

  before do
    @user = FactoryGirl.create(:american_user)
    visit new_bicycle_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
  end

  scenario 'User fails to enter any information' do
    click_button 'Register'
    expect(page).to have_content 'blank'
  end

  scenario 'User submits information', js: true do
    fill_in 'date_picker', with: "01/01/2010"
    fill_in 'City', with: bicycle.city
    select(bicycle.region, from: 'State')
    select(bicycle.country, from: 'bicycle_country')
    fill_in 'bicycle_description', with: bicycle.description
    click_button 'Register'
    uri = URI.parse(current_url)
    "#{uri.path}".should == "/bicycles/#{Bicycle.last.id}"
  end

  scenario 'User edits one of their bicycles' do
    @bicycle = FactoryGirl.create(:bicycle, user_id: @user.id)
    visit edit_bicycle_path(@bicycle)
    fill_in 'bicycle_color', with: 'Mauve'
    click_button 'Register'
    @bicycle.color.should be 'Mauve'
  end

  scenario 'User edits and is redirected to the listing' do
    @bicycle = FactoryGirl.create(:bicycle, user_id: @user.id)
    visit edit_bicycle_path(@bicycle)
    fill_in 'bicycle_color', with: 'Mauve'
    click_button 'Register'
    uri = URI.parse(current_url)
    "#{uri.path}".should == "/bicycles/#{@bicycle.id}"
  end
end