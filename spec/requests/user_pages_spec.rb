require 'spec_helper'

feature 'User pages' do
  
  before do
    @user = FactoryGirl.create(:american_user)
    @user2 = FactoryGirl.create(:canadian_user)
    @bicycle = FactoryGirl.create(:bicycle, user_id: @user.id)
  end

  scenario 'the user tries to register a bike and is redirected to the login page' do
    visit new_bicycle_path
    uri = URI.parse(current_url)
    "#{uri.path}".should == new_user_session_path
  end

  scenario 'after being redirected and logging in, they are redirected back' do
    visit new_bicycle_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
    uri = URI.parse(current_url)
    "#{uri.path}".should == new_bicycle_path
  end

  scenario 'the user can see all of their bicycles' do
    visit new_bicycle_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
    visit user_path(@user)
    page.should have_content @bicycle.date
  end

  scenario 'the user cannot see someone else\'s bicycles' do
    visit new_bicycle_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
    visit user_path(@user2)
    uri = URI.parse(current_url)
    "#{uri.path}".should == new_bicycle_path
    page.should have_content 'Access denied'
  end

  scenario 'the user can visit a bicycle listing by clicking on it' do
    visit new_bicycle_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
    visit user_path(@user)
    click_link 'Edit listing'
    page.should have_content 'Edit'
  end
end