require 'rails_helper'

feature 'user deletes account', %q(
  As an authenticated user
  I want to delete my account
  So that my information is no longer retained by the app
) do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user sees delete option' do
    sign_in user

    visit edit_user_registration_path

    expect(page).to have_content('Unhappy?')
    expect(page).to have_button('Cancel my account')
  end

  scenario 'authenticated user deletes account successfully' do
    sign_in user

    visit edit_user_registration_path
    click_button 'Cancel my account'

    expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
  end
end
