require 'rails_helper'

feature 'user deletes review' do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:hotel) { FactoryGirl.create(:hotel) }
  let!(:review) { FactoryGirl.create(:review, hotel: hotel, user: user1)}

  scenario 'authenticated user sees reviews' do
    sign_in user1
    visit hotel_path(hotel)

    expect(page).to have_content("great location nears transporation")
    expect(page).to have_link("Delete")
  end

  scenario 'authenticated user deletes review posted by user successfully' do
    sign_in user1
    visit hotel_path(hotel)

    click_link "Delete"

    expect(page).to have_content("The review was deleted.")
  end

  scenario 'authenticated user attempts to delete review posted by other' do
    sign_in user2
    visit hotel_path(hotel)

    expect(page).not_to have_link("Delete")
  end

  scenario 'unauthoticated user attemps to delete review' do
    visit hotel_path(hotel)

    expect(page).not_to have_link("Delete")
  end
end
