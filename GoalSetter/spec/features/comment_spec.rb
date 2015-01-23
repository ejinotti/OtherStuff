require 'rails_helper'
require 'spec_helper'

feature "creating a comment" do

  scenario "has buttons for commenting on users/goals" do
    create_user_mike
    click_button "Create Goal"
    create_goal "Pass da test", "Public"
    expect(page).to have_selector(:link_or_button, "Comment on User")
    expect(page).to have_selector(:link_or_button, "Comment on Goal")
  end

  scenario "can create comment on a user" do
    create_user_mike
    click_button "Comment on User"
    comment "blah blah blah"
    expect(page).to have_content("blah blah blah")
  end

  scenario "can create comment on a goal" do
    create_user_mike
    click_button "Create Goal"
    create_goal "Pass da test", "Public"
    click_button "Comment on Goal"
    comment "blah blah blah"
    expect(page).to have_content("blah blah blah")
  end

end
