require 'spec_helper'

feature 'Registration' do
  scenario 'User fails to enter any information' do
    visit new_bicycle_path
    click_button 'Register'
    expect(page).to have_content 'blank'
  end
end