require_relative '../acceptance_helper'

feature 'Create flavors', %q{
  In order to be able to select flavors in recipes
  As a user
  I want to be able create flavors
} do

  given(:user) { create(:user) }
  given(:user_admin) { create(:user_admin) }
  given(:user_moderator) { create(:user_moderator) }
  given(:flavor) { create(:flavor) }

  scenario 'User tries create flavor' do
    sign_in(user)

    visit new_flavor_path

    expect(page).to have_content 'Нет доступа.'
    expect(current_path).to eq root_path
  end

  scenario 'Admin creates flavor' do
    sign_in(user_admin)

    visit new_flavor_path

    fill_in 'Name', with: flavor.name
    click_on 'Создать'

    visit flavors_path
    expect(page).to have_content flavor.name
  end

  scenario 'Moderator creates flavor' do
    sign_in(user_admin)

    visit new_flavor_path

    fill_in 'Name', with: flavor.name
    click_on 'Создать'

    visit flavors_path
    expect(page).to have_content flavor.name
  end

  scenario 'Non-authenticated user tries create flavor' do
    visit new_flavor_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end
end
