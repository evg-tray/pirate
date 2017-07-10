require_relative '../acceptance_helper'

feature 'Edit flavors', %q{
  In order to be able to edit flavors
  As a user
  I want to be able edit flavors
} do

  given(:user) { create(:user) }
  given(:user_admin) { create(:user_admin) }
  given(:user_moderator) { create(:user_moderator) }
  given(:user_flavor_creator) { create(:user_flavor_creator) }
  given!(:flavor) { create(:flavor) }

  scenario 'User tries edit flavor' do
    sign_in(user)

    visit edit_flavor_path(flavor)

    expect(page).to have_content t('authorization.errors.forbidden')
    expect(current_path).to eq root_path
  end

  scenario 'Admin edit flavor', js: true do
    sign_in(user_admin)

    visit edit_flavor_path(flavor)

    fill_in t('activerecord.attributes.flavor.name'), with: 'new flavor name'

    click_on t('flavors.form.edit_flavor')

    visit flavors_path
    expect(page).to have_content 'new flavor name'
  end

  scenario 'Moderator edit flavor', js: true do
    sign_in(user_moderator)

    visit edit_flavor_path(flavor)

    fill_in t('activerecord.attributes.flavor.name'), with: 'new flavor name'

    click_on t('flavors.form.edit_flavor')

    visit flavors_path
    expect(page).to have_content 'new flavor name'
  end

  scenario 'Flavor creator edit flavor', js: true do
    sign_in(user_flavor_creator)

    visit edit_flavor_path(flavor)

    fill_in t('activerecord.attributes.flavor.name'), with: 'new flavor name'

    click_on t('flavors.form.edit_flavor')

    visit flavors_path
    expect(page).to have_content 'new flavor name'
  end

  scenario 'Non-authenticated user tries edit flavor' do
    visit edit_flavor_path(flavor)

    expect(page).to have_content t('devise.failure.unauthenticated')
    expect(current_path).to eq new_user_session_path
  end
end
