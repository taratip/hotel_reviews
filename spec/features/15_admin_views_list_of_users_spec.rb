require 'rails_helper'

feature 'admin views a list of users' do
  let!(:users) { FactoryGirl.create_list(:user, 10, role: "member") }
  let!(:admin) { FactoryGirl.create(:user, role: "admin") }

  scenario 'unauthenticated user attempts to see a list of user' do
    visit "/"

    expect(page).not_to have_link('Admin Section')
  end

  scenario 'authenticated user attempts to see a list of user' do
    sign_in users[0]

    visit "/"

    expect(page).not_to have_link('Admin Section')
  end

  scenario 'admin sees option to view a list of all users' do
    sign_in admin

    visit "/"

    expect(page).to have_link('Admin Section')
  end

  scenario 'admin sees a list of all users' do
    sign_in admin
    visit "/"

    click_link "Users"

    expect(page).to have_content(users[0].email)
    expect(page).to have_content(users[1].email)
  end

  scenario 'member attemps to see user list via url' do
    sign_in users[0]

    visit admin_users_path

    expect(page).to have_content("You are not authorized to view this resource.")
  end
end
