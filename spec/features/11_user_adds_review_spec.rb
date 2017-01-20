require "rails_helper"

feature 'user adds a review for a hotel' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:hotel) { FactoryGirl.create(:hotel) }

  scenario "user sees hotel's details" do
    visit hotel_path(hotel)

    expect(page).to have_content(hotel.name)
    expect(page).to have_content("Reviews")
  end

  scenario "authenticated user adds review with valid information" do
    sign_in user

    visit hotel_path(hotel)

    select 5, from: "Rating"
    fill_in "Review", with: "Beautiful location, great atmosphere, I'll visit there again!"
    click_button "Create Review"

    expect(page).to have_content("Thanks for your input!")
  end

  scenario "unauthoticated user attemps to add a review" do
    visit hotel_path(hotel)

    expect(page).to have_content("Sign in to create a review")
  end
end
