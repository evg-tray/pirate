require_relative '../acceptance_helper'

feature 'Add moderators', %q{
  In order to be able to add role moderator to user
  As an admin user
  I want to be able to add moderator
} do

  given!(:user) { create(:user) }
  given!(:user_admin) { create(:user_admin) }

  scenario 'User-admin add role moderator to user', js: true do
    sign_in(user_admin)
    visit admin_path

    select2(user.username, 'user_id')

    click_on 'Сделать модератором'

    within '.moderators' do
      expect(page).to have_content user.username
    end
  end
end
