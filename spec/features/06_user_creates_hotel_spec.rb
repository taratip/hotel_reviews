require 'rails_helper'
require 'pry'

feature 'user adds hotel', %q(
  As an authenticated user
  I want to add an item
  So that others can review it
) do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user can add new hotel' do
    sign_in user
    visit root_path
    
    expect(page).to have_link('Add new hotel')
  end

  scenario 'authenticated user adds new hotel successfully' do
    sign_in user
    visit new_hotel_path

    fill_in 'Name', with: 'Harbor Park Hotel'
    fill_in 'Address', with: '217, Jemullyang-ro, Jung-gu, Incheon, Incheon, 400-033, South Korea'
    fill_in 'Number of rooms', with: '270'
    click_button 'Add hotel'

    expect(page).to have_content('Hotel was successfully created.')
  end

  scenario 'authenticated user adds new hotel with invalid information and sees errors' do
    sign_in user
    visit new_hotel_path

    fill_in 'Name', with: 'Harbor Park Hotel'
    fill_in 'Address', with: ''
    fill_in 'Number of rooms', with: '270'
    click_button 'Add hotel'

    expect(page).to have_content("Address can't be blank")
    expect(page).to have_field("Name", with: "Harbor Park Hotel")
  end

  scenario 'unauthenticated user attempts to create a new hotel' do
    visit "/"

    expect(page).not_to have_link('Add new hotel')
  end
end
