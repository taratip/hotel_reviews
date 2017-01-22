require 'rails_helper'

feature 'admin deletes a review' do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:user, role: "admin") }

  let!(:hotel1) { FactoryGirl.create(:hotel) }
  let!(:review) { FactoryGirl.create(:review, hotel: hotel1)}

  scenario 'admin sees delete links on hotel detail page' do
    sign_in admin

    visit hotel_path(hotel1)

    within "div#vote-#{review.id}" do
      expect(page).to have_link('Delete')
    end
  end

  scenario 'admin deletes a review' do
    sign_in admin

    visit hotel_path(hotel1)
    find("div#vote-#{review.id}").click_link("Delete")

    expect(page).to have_content("The review was deleted.")
  end
end
