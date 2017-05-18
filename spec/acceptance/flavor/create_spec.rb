require_relative '../acceptance_helper'

feature 'Create flavors', %q{
  In order to be able to select flavors in recipes
  As a user
  I want to be able create flavors
} do

  given(:user) { create(:user) }
  given(:user_admin) { create(:user_admin) }
  given(:user_moderator) { create(:user_moderator) }
  given(:flavor) { build(:flavor) }
  given!(:manufacturer) { create(:manufacturer) }

  scenario 'User tries create flavor' do
    sign_in(user)

    visit new_flavor_path

    expect(page).to have_content t('authorization.errors.forbidden')
    expect(current_path).to eq root_path
  end

  scenario 'Admin creates flavor', js: true do
    sign_in(user_admin)

    visit new_flavor_path

    fill_in t('activerecord.attributes.flavor.name'), with: flavor.name
    select2(manufacturer.name, 'flavor_manufacturer_id')
    click_on t('flavors.new.create_flavor')

    visit flavors_path
    expect(page).to have_content flavor.name
  end

  scenario 'Moderator creates flavor', js: true do
    sign_in(user_admin)

    visit new_flavor_path

    fill_in t('activerecord.attributes.flavor.name'), with: flavor.name
    select2(manufacturer.name, 'flavor_manufacturer_id')
    click_on t('flavors.new.create_flavor')

    visit flavors_path
    expect(page).to have_content flavor.name
  end

  scenario 'Non-authenticated user tries create flavor' do
    visit new_flavor_path

    expect(page).to have_content t('devise.failure.unauthenticated')
    expect(current_path).to eq new_user_session_path
  end
end
