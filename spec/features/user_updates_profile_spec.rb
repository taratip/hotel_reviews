require 'rails_helper'

feature 'user updates profile', %q(
  As an authenticated user
  I want to update my information
  So that I can keep my profile up to date
) do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user sees information' do
    sign_in user

    visit edit_user_registration_path

    expect(page).to have_content('Edit User')
  end

  scenario 'authenticated user updates profile with valid information' do
    sign_in user
    visit edit_user_registration_path
    fill_in 'Email', with: 'john@exmple.com'
    fill_in 'Current password', with: 'password'
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
  end

  scenario 'authenticated user updates with invalid information and sees errors' do
    sign_in user
    visit edit_user_registration_path
    fill_in 'Email', with: ''
    click_button 'Update'

    expect(page).to have_content("Email can't be blank")
  end
end
