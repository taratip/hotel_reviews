require 'rails_helper'

feature 'admin deletes a hotel' do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:user, role: "admin") }

  let!(:hotel1) { FactoryGirl.create(:hotel, user: user1) }

  scenario 'admin sees delete link on hotel details page' do
    sign_in admin
    visit hotel_path(hotel1)

    within "div#hotel" do
      expect(page).to have_link('Delete')
    end
  end

  scenario 'admin deletes a hotel' do
    sign_in admin
    visit hotel_path(hotel1)

    within "div#hotel" do
      click_link "Delete"
    end
    
    expect(page).to have_content('The hotel was deleted.')
  end
end
