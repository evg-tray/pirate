require_relative '../acceptance_helper'

feature 'Create manufacturers', %q{
  In order to be able to group flavors by manufacturer
  As a user
  I want to be able create manufacturers
} do

  given(:user) { create(:user) }
  given(:user_admin) { create(:user_admin) }
  given(:user_moderator) { create(:user_moderator) }
  given(:manufacturer) { create(:manufacturer) }

  scenario 'User tries create manufacturer' do
    sign_in(user)

    visit new_manufacturer_path

    expect(page).to have_content 'Нет доступа.'
    expect(current_path).to eq root_path
  end

  scenario 'Admin creates manufacturer' do
    sign_in(user_admin)

    visit new_manufacturer_path

    fill_in 'Name', with: manufacturer.name
    click_on 'Создать'

    visit manufacturers_path
    expect(page).to have_content manufacturer.name
  end

  scenario 'Moderator creates manufacturer' do
    sign_in(user_admin)

    visit new_manufacturer_path

    fill_in 'Name', with: manufacturer.name
    click_on 'Создать'

    visit manufacturers_path
    expect(page).to have_content manufacturer.name
  end

  scenario 'Non-authenticated user tries create manufacturer' do
    visit new_manufacturer_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end
end
