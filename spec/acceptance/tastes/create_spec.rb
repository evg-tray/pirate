require_relative '../acceptance_helper'

feature 'Create tastes', %q{
  In order to be able to select tastes of recipe
  As a admin
  I want to be able create tastes
} do

  given(:user_admin) { create(:user_admin) }
  given(:user) { create(:user) }
  given(:taste) { build(:taste) }

  scenario 'Admin create taste' do
    sign_in(user_admin)

    click_on t('layouts.navbar.tastes')
    within 'p' do
      click_on t('tastes.index.create_taste')
    end
    find('#taste_name').set(taste.name)
    within 'form' do
      click_on t('tastes.form.create_taste')
    end
    visit tastes_path
    expect(page).to have_content taste.name
  end

  scenario 'User not admin tries create taste' do
    sign_in(user)
    expect(page).not_to have_content t('layouts.navbar.tastes')

    visit tastes_path
    expect(page).to have_content t('authorization.errors.forbidden')
  end

  scenario 'Not-authenticated user tries create taste' do
    visit root_path
    expect(page).not_to have_content t('layouts.navbar.tastes')

    visit tastes_path
    expect(page).to have_content t('devise.failure.unauthenticated')
    expect(current_path).to eq new_user_session_path
  end
end
