require 'rails_helper'
require 'pry'

feature 'admin deletes user' do
  let!(:users) { FactoryGirl.create_list(:user, 5, role: "member") }
  let!(:admin) { FactoryGirl.create(:user, role: "admin") }

  scenario 'admin can delete a user' do
    sign_in admin
    visit admin_users_path

    expect(page).to have_button('Delete')
  end

  scenario 'admin can delete a user' do
    sign_in admin
    visit admin_users_path

    find("ul#users div.user:first-child input[type='submit']").click

    expect(page).to have_content("The user was deleted.")
  end

  scenario 'member attempts to delete a user' do
    sign_in users[0]
    visit "/"

    expect(page).not_to have_link('Admin Section')

    visit admin_users_path
    expect(page).to have_content("You are not authorized to view this resource.")
  end
end
