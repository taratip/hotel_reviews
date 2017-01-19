require 'rails_helper'

feature 'user deletes hotel', %q(
  As an authenticated user
  I want to delete an item created by me
  So that no one can review it
) do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }

  let!(:hotel1) { FactoryGirl.create(:hotel, user: user1) }

  scenario 'authenticated user sees delete link on hotel details page' do
    sign_in user1
    visit hotel_path(hotel1)

    expect(page).to have_link('Delete')
  end

  scenario 'authenticated user can delete a hotel created by the user' do
    sign_in user1
    visit hotel_path(hotel1)
    click_link 'Delete'

    expect(page).to have_content('The hotel was deleted.')
  end

  scenario 'authenticated user cannot delete a hotel created by other user' do
    sign_in user2
    visit hotel_path(hotel1)

    expect(page).not_to have_link('Delete')
  end

  scenario 'unauthenticated user attempts to delete a hotel' do
    visit "/"
    visit hotel_path(hotel1)

    expect(page).not_to have_link("Delete")
  end
end
