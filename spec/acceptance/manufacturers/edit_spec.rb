require_relative '../acceptance_helper'

feature 'Edit manufacturers', %q{
  In order to be able to edit manufacturer
  As a user
  I want to be able edit manufacturers
} do

  given(:user) { create(:user) }
  given(:user_admin) { create(:user_admin) }
  given(:user_moderator) { create(:user_moderator) }
  given(:user_flavor_creator) { create(:user_flavor_creator) }
  given!(:manufacturer) { create(:manufacturer) }

  scenario 'User tries edit manufacturer' do
    sign_in(user)

    visit edit_manufacturer_path(manufacturer)

    expect(page).to have_content t('authorization.errors.forbidden')
    expect(current_path).to eq root_path
  end

  scenario 'Admin edits manufacturer' do
    sign_in(user_admin)

    visit edit_manufacturer_path(manufacturer)

    fill_in t('activerecord.attributes.manufacturer.name'), with: 'new manufacturer name'

    within '.panel-body' do
      click_on t('manufacturers.edit.edit_manufacturer')
    end

    visit manufacturers_path
    expect(page).to have_content 'new manufacturer name'
  end

  scenario 'Moderator edit manufacturer' do
    sign_in(user_moderator)

    visit edit_manufacturer_path(manufacturer)

    fill_in t('activerecord.attributes.manufacturer.name'), with: 'new manufacturer name'

    within '.panel-body' do
      click_on t('manufacturers.edit.edit_manufacturer')
    end

    visit manufacturers_path
    expect(page).to have_content 'new manufacturer name'
  end

  scenario 'Flavor creator edit manufacturer' do
    sign_in(user_flavor_creator)

    visit edit_manufacturer_path(manufacturer)

    fill_in t('activerecord.attributes.manufacturer.name'), with: 'new manufacturer name'

    within '.panel-body' do
      click_on t('manufacturers.edit.edit_manufacturer')
    end

    visit manufacturers_path
    expect(page).to have_content 'new manufacturer name'
  end

  scenario 'Non-authenticated user tries edit manufacturer' do
    visit edit_manufacturer_path(manufacturer)

    expect(page).to have_content t('devise.failure.unauthenticated')
    expect(current_path).to eq new_user_session_path
  end
end
