require 'rails_helper'
require 'pry'

feature 'user updates review' do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:hotel) { FactoryGirl.create(:hotel) }
  let!(:review) { FactoryGirl.create(:review, hotel: hotel, user: user1)}

  scenario 'authenticated user sees reviews' do
    sign_in user1
    visit hotel_path(hotel)

    expect(page).to have_content("great location nears transporation")
    expect(page).to have_link("Update")
  end

  scenario 'authenticated user updates review posted by user successfully' do
    sign_in user1
    visit hotel_path(hotel)

    click_link "Update"

    select 1, from: "Rating"
    fill_in "Review", with: "Not that good, very old building"

    click_button "Update Review"

    expect(page).to have_content("Review was successfully updated.")
  end

  scenario 'authenticated user attempts to update review posted by other' do
    sign_in user2
    visit hotel_path(hotel)

    expect(page).not_to have_link("Update")
  end

  scenario 'authenticated user cannot edit review posted by other user from url' do
    sign_in user2
    visit edit_review_path(review)

    fill_in "Review", with: "Not so good"
    click_button "Update Review"

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario 'unauthoticated user attempts to update review' do
    visit "/"

    expect{visit edit_review_path(review)}.to raise_error(ActionController::RoutingError)
  end
end
