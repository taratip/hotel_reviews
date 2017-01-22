require 'rails_helper'

feature 'user votes on reviews' do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:hotel) { FactoryGirl.create(:hotel) }
  let!(:review) { FactoryGirl.create(:review, hotel: hotel, user: user1)}

  scenario 'user sees a review score' do
    visit hotel_path(hotel)

    within "div#vote-#{review.id}" do
      expect(page.find('span')).to have_content("0")
    end
  end

  scenario 'authenticated user vote up a review' do
    sign_in user1
    visit hotel_path(hotel)

    within "div#vote-#{review.id}" do
      click_button "+1"
    end

    within "div#vote-#{review.id}" do
      expect(page.find('span')).to have_content("1")
    end
    expect(page).to have_content("Thank you for your vote!")
  end

  scenario 'authenticated user vote down a review' do
    sign_in user1
    visit hotel_path(hotel)

    within "div#vote-#{review.id}" do
      click_button "-1"
    end

    within "div#vote-#{review.id}" do
      expect(page.find('span')).to have_content("-1")
    end
    expect(page).to have_content("Thank you for your vote!")
  end

  scenario 'unauthenticated user attempts to vote a review' do
    visit hotel_path(hotel)

    expect(page).not_to have_button("+1")
    expect(page).not_to have_button("-1")
  end

  scenario 'authenticated user attempts to vote the same twice' do
    sign_in user1
    visit hotel_path(hotel)

    within "div#vote-#{review.id}" do
      click_button "+1"
      click_button "+1"
    end

    within "div#vote-#{review.id}" do
      expect(page.find('span')).to have_content("1")
    end
  end

  scenario 'authenticated user delete vote' do
    sign_in user1
    visit hotel_path(hotel)

    within "div#vote-#{review.id}" do
      click_button "+1"
      click_button "Delete Vote"
    end

    expect(page).to have_content("Your vote was deleted.")
    within "div#vote-#{review.id}" do
      expect(page.find('span')).to have_content("0")
    end
  end

  scenario 'authenticated user attempts to delete vote that was not voted by the user' do
    sign_in user1
    visit hotel_path(hotel)

    within "div#vote-#{review.id}" do
      click_button "Delete Vote"
    end

    expect(page).to have_content("There was a problem with your vote.")
  end
end
