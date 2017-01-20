require 'rails_helper'
require 'pry'

feature "user views hotel's reviews" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:hotel) { FactoryGirl.create(:hotel) }
  let!(:review) { FactoryGirl.create(:review, hotel: hotel) }

  scenario "user sees hotel's details" do
    visit hotel_path(hotel)

    expect(page).to have_content(hotel.name)
    expect(page).to have_content("Reviews")
  end

  scenario "user sees hotel's reviews" do
    visit hotel_path(hotel)

    expect(page).to have_content(review.body)
    expect(page).to have_content(review.rating)
  end
end
