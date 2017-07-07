require_relative '../acceptance_helper'

feature 'Edit, view tastes', %q{
  In order to be able to edit, view tastes
  As a admin
  I want to be able edit/view tastes
} do

  given(:user_admin) { create(:user_admin) }
  given(:user) { create(:user) }
  given!(:taste) { create(:taste) }

  scenario 'Admin views tastes' do
    sign_in(user_admin)

    visit tastes_path
    expect(page).to have_content taste.name
  end

  scenario 'Admin edit taste' do
    sign_in(user_admin)

    click_on t('layouts.navbar.tastes')
    click_on taste.name
    find('#taste_name').set('new taste name')
    within 'form' do
      click_on t('tastes.form.edit_taste')
    end
    visit tastes_path
    expect(page).to have_content 'new taste name'
  end

  scenario 'User not admin tries view taste' do
    sign_in(user)
    expect(page).not_to have_content t('layouts.navbar.tastes')

    visit tastes_path
    expect(page).to have_content t('authorization.errors.forbidden')
  end

  scenario 'Not-authenticated user tries view taste' do
    visit root_path
    expect(page).not_to have_content t('layouts.navbar.tastes')

    visit tastes_path
    expect(page).to have_content t('devise.failure.unauthenticated')
    expect(current_path).to eq new_user_session_path
  end
end
