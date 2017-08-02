require_relative '../acceptance_helper'

feature 'Disable registration', %q{
  In order to be able to temporary disable registation new users
  As an admin user
  I want to be able to disable registation
} do

  given!(:user_admin) { create(:user_admin) }

  scenario 'User-admin disables registration', js: true, clear_cache: true do
    sign_in(user_admin)
    visit admin_path

    click_on t('admins.disable_registration')

    click_on user_admin.username
    click_on t('devise.sessions.sign_out')

    visit new_user_registration_path
    expect(page).to have_content t('devise.disabled_registration')
    expect(current_path).to eq root_path
  end
end
