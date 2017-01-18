require 'rails_helper'
require 'pry'

feature 'user signs in', %q(
  As an unauthenticated user
  I want to sign in
  So that I can post items and review them
) do
  scenario 'specify valid credentials' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Sign out')
  end

  scenario 'specify invalid credentials' do
    visit new_user_session_path

    click_on 'Log in'
    
    expect(page).to have_content('Invalid Email or password')
    expect(page).to_not have_content('Sign out')
  end
end
