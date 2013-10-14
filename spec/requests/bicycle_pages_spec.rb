require 'spec_helper'

feature 'Registration' do
  scenario 'User fails to enter any information' do
    visit new_bicycle_path
    click_button 'Submit'
    expect(page).to have_content 'error'
  end
end