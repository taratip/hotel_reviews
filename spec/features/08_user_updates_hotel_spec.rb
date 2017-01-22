require 'rails_helper'

feature 'user updates hotel information', %q(
  As an authenticated user
  I want to update an item's information that I created
  So that I can correct errors or provide new information
) do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }

  let!(:hotel1) { FactoryGirl.create(:hotel, user: user1) }

  scenario 'authenticated user can edit hotel information created by the user' do
    sign_in user1
    visit hotel_path(hotel1)

    expect(page).to have_link('Edit')
  end

  scenario 'authenticated user updates hotel with valid information' do
    sign_in user1
    visit edit_hotel_path(hotel1)

    fill_in "Name", with: "Hotel Park Korea"
    attach_file "Image", "#{Rails.root}/spec/support/images/hotel.jpg"
    click_button "Save"

    expect(page).to have_content("Hotel was successfully updated.")
    expect(page).to have_content("Hotel Park Korea")
    expect(page).to have_css("img[src*='hotel.jpg']")
  end

  scenario 'authenticated user updates hotel with invalid information and sees errors' do
    sign_in user1
    visit edit_hotel_path(hotel1)

    fill_in "Name", with: "Hotel Park Korea"
    fill_in "Address", with: ""
    click_button "Save"

    expect(page).to have_content("Address can't be blank")
  end

  scenario 'authenticated user cannot edit hotel information posted by other user' do
    sign_in user2
    visit hotel_path(hotel1)

    expect(page).not_to have_link("Edit")
  end

  scenario 'authenticated user cannot edit hotel information posted by other user from url' do
    sign_in user2
    visit edit_hotel_path(hotel1)

    fill_in "Name", with: "Hotel Park Korea"
    click_button "Save"

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario 'unauthenticated user attempts to edit hotel information' do
    visit "/"

    expect{visit edit_hotel_path(hotel1)}.to raise_error(ActionController::RoutingError)
  end
end
