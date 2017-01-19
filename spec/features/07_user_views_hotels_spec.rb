require 'rails_helper'
require 'pry'

feature 'user views hotels', %q(
  all users can view hotels
) do
  let!(:user) { FactoryGirl.create(:user) }

  let!(:hotel1) { FactoryGirl.create(:hotel) }
  let!(:hotel2) { FactoryGirl.create(:hotel) }

  scenario 'unauthenticated user can view hotels' do
    visit "/"

    expect(page).to have_content(hotel1.name)
    expect(page).to have_content(hotel2.name)
  end

  scenario 'authenticated user can view hotels' do
    sign_in user
    visit "/"

    expect(page).to have_content(hotel1.name)
    expect(page).to have_content(hotel2.name)
  end

  scenario 'user view hotel details' do
    visit "/"

    click_link hotel1.name

    expect(page).to have_content(hotel1.name)
    expect(page).to have_content(hotel1.address)
  end
end
