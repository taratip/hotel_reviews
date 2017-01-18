require 'rails_helper'

feature 'user can create account', %q(
  As a prospective user
  I want to create an account
  So that I can post items and review them
) do

  scenario 'user visits hotels index' do
    visit root_path

    expect(page).to have_content('Sign up')
  end

  scenario 'user provides valid information' do
    visit root_path
    click_link 'Sign up'

    fill_in 'Email', with: 'john@exmple.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Sign out')
  end

  scenario 'user sees errors when provided invalid information' do
    visit new_user_registration_path

    click_button 'Sign up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Sign out')
  end
end
