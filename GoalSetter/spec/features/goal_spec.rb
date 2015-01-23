require 'rails_helper'
require 'spec_helper'

feature "creating a goal" do

  scenario "has button to create goal on user's page" do
    create_user_mike
    expect(page).to have_selector(:link_or_button, "Create Goal")
  end

  scenario "can create a goal" do
    create_user_mike
    click_button "Create Goal"
    create_goal "Pass da test", "Public"
    expect(page).to have_content("Pass da test")
    expect(page).to have_content("Public")
  end

end

feature "reading goals" do

  scenario "can see other user's public goals" do
    create_user_mike
    click_button "Create Goal"
    create_goal "Pass da test", "Public"
    sign_out
    create_user_ed
    visit user_url(1)

    expect(page).to have_content("Pass da test")
    expect(page).not_to have_content("Public")
  end

  scenario "can't see other user's private goals" do
    create_user_mike
    click_button "Create Goal"
    create_goal "Pass da test", "Private"
    sign_out
    create_user_ed
    visit user_url(1)

    expect(page).to have_content("mike")
    expect(page).not_to have_content("Pass da test")
  end

end

feature "updating a goal" do

  scenario "can edit goal" do
    create_user_mike
    click_button "Create Goal"
    create_goal "Pass da test", "Public"
    click_button "Edit"
    edit_goal "Fail da test", "Private"

    expect(page).to have_content("Fail da test")
    expect(page).to have_content("Private")
  end

  scenario "can't update another user's goals" do
    create_user_mike
    click_button "Create Goal"
    create_goal "Pass da test", "Private"
    sign_out
    create_user_ed
    visit user_url(1)

    expect(page).not_to have_selector(:link_or_button, "Edit")
  end

end

feature "deleting goals" do

  scenario "can delete user's own goals" do
    create_user_mike
    click_button "Create Goal"
    create_goal "Pass da test", "Public"
    click_button "Delete"

    expect(page).not_to have_content("Pass da test")
  end

  scenario "can't delete another user's goals" do
    create_user_mike
    click_button "Create Goal"
    create_goal "Pass da test", "Private"
    sign_out
    create_user_ed
    visit user_url(1)

    expect(page).not_to have_selector(:link_or_button, "Delete")
  end

end

feature "comlpeting goals" do

  scenario "can mark a goal as complete" do
    create_user_mike
    click_button "Create Goal"
    create_goal "Pass da test", "Private"
    click_button "Mark Complete"

    expect(page).to have_content("COMPLETED")
  end

  scenario "can't mark other users' goals as complete" do
    create_user_mike
    click_button "Create Goal"
    create_goal "Pass da test", "Private"
    sign_out
    create_user_ed
    visit user_url(1)

    expect(page).not_to have_selector(:link_or_button, "Mark Complete")
  end

end
