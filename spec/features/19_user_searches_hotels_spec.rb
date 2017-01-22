require 'rails_helper'

feature 'user searches for hotels' do
  scenario 'user searches for hotels using a search bar' do
    hotels = FactoryGirl.create_list(:hotel, 10)
    visit root_path

    fill_in "query", with: "park"
    click_button "Search"

    expect(page).to have_css("div.records li", :count => 10)
  end
end
