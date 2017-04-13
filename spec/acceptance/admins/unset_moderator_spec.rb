require_relative '../acceptance_helper'

feature 'Remove moderators', %q{
  In order to be able to remove role moderator from user
  As an admin user
  I want to be able to remove moderator
} do

  given!(:user_moderator) { create(:user_moderator) }
  given!(:user_admin) { create(:user_admin) }

  scenario 'User-admin remove role moderator from user', js: true do
    sign_in(user_admin)
    visit admin_path

    within '.moderators' do
      find("#user-#{user_moderator.id}").click
    end
    expect(page).not_to have_content user_moderator.username
  end
end
