require 'spec_helper'

feature 'User pages' do

  let(:bicycle) { FactoryGirl.create(:bicycle) }
  let(:user) { bicycle.user }
  let(:canadian_user) { FactoryGirl.create(:canadian_user) }
  let(:american_user) { FactoryGirl.build(:american_user) }

  scenario 'the user tries to register a bike and is redirected to the login page' do
    visit new_bicycle_path
    uri = URI.parse(current_url)
    "#{uri.path}".should == new_user_session_path
  end

  scenario 'after being redirected and logging in, they are redirected back' do
    visit new_bicycle_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    uri = URI.parse(current_url)
    "#{uri.path}".should == new_bicycle_path
  end

  scenario 'the user can visit a bicycle listing by clicking on it' do
    visit new_bicycle_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    visit user_path(user)
    click_link 'Edit'
    page.should have_content 'Edit'
  end

  scenario 'visitors can sign up', js: true do
    visit new_user_registration_path
    fill_in 'First Name', with: american_user.first_name
    fill_in 'Last Name', with: american_user.last_name
    fill_in 'Email', with: american_user.email
    select('United States', from: 'user_country')
    fill_in 'City', with: american_user.city
    select('OR', from: 'State')
    fill_in 'Zip Code', with: american_user.postal_code
    fill_in 'Phone', with: american_user.phone1
    fill_in 'Password (min 8 char.)', with: american_user.password
    fill_in 'Password Confirmation', with: american_user.password
    click_button 'Sign up'
    uri = URI.parse(current_url)
    "#{uri.path}".should == new_bicycle_path
  end

  scenario 'user selects country \'Canada\' and gets selector to specify a province', js: true do
    visit new_user_registration_path
    select('Canada', from: 'user_country')
    page.has_selector?('Province')
  end

  scenario 'user selects country \'United States\' and gets selector to specify a state', js: true do
    visit new_user_registration_path
    select('United States', from: 'user_country')
    page.has_selector?('States')
  end

  context 'after signing in' do
    before do
      visit new_bicycle_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end

    scenario 'the user can see all of their bicycles' do
      visit user_path(user)
      page.should have_content bicycle.date
    end

    scenario 'the user cannot see someone else\'s bicycles' do
      visit user_path(canadian_user)
      page.should have_content 'Access denied'
    end

    scenario 'the user is redirected back when they visit the registration page' do
      visit root_path
      visit new_user_registration_path
      uri = URI.parse(current_url)
      "#{uri.path}".should == root_path
    end

    scenario 'the user receives an error message when they visit the registration page' do
      visit root_path
      visit new_user_registration_path
      page.should have_content('You are already signed in')
    end
  end
end
