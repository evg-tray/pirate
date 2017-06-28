require_relative '../acceptance_helper'

feature 'View admin panel', %q{
  In order to be able to manage application
  As an admin user
  I want to be able to view admin panel
} do

  given!(:user) { create(:user) }
  given!(:user_admin) { create(:user_admin) }

  scenario 'User-admin views admin panel' do
    sign_in(user_admin)
    visit admin_path
    expect(page).to have_content t('admins.show.title')
  end

  scenario 'Non-admin user tries view admin panel' do
    sign_in(user)
    visit admin_path
    expect(current_path).to eq root_path
    expect(page).to have_content t('authorization.errors.forbidden')
  end

  scenario 'Non-authenticated user tries view admin panel' do
    visit admin_path
    expect(current_path).to eq new_user_session_path
  end
end
