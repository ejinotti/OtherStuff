# spec/features/auth_spec.rb

require 'rails_helper'
require 'spec_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Create a New User"
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      create_user_mike

      expect(page).to have_content("mike")
    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    create_user_mike
    sign_out
    sign_in_mike

    expect(page).to have_content("mike")
  end

end

feature "logging out" do

  scenario "begins with logged out state" do
    visit root_url

    expect(page).not_to have_selector(:link_or_button, "Sign Out")
  end

  scenario "doesn't show username on the homepage after logout" do
    create_user_mike
    sign_out

    expect(page).not_to have_content("mike")
  end

end
