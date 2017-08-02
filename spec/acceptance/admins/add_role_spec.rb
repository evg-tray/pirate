require_relative '../acceptance_helper'

feature 'Add roles', %q{
  In order to be able to add role to user
  As an admin user
  I want to be able to add role
} do

  given!(:user) { create(:user) }
  given!(:user_admin) { create(:user_admin) }

  scenario 'User-admin add role moderator to user', js: true do
    sign_in(user_admin)
    visit admin_path

    select2(user.username, 'user_id')

    click_on t('admins.show.add_moderator')

    within '.table' do
      expect(page).to have_content user.username
      within 'td:nth-child(2)' do
        expect(page).to have_selector 'a'
      end
    end
  end

  scenario 'User-admin add role flavor creator to user', js: true do
    sign_in(user_admin)
    visit admin_path

    select2(user.username, 'user_id')

    click_on t('admins.show.add_flavor_creator')

    within '.table' do
      expect(page).to have_content user.username
      within 'td:nth-child(3)' do
        expect(page).to have_selector 'a'
      end
    end
  end

  scenario 'User-admin add role pirate diy creator to user', js: true do
    sign_in(user_admin)
    visit admin_path

    select2(user.username, 'user_id')

    click_on t('admins.show.add_pirate_diy_creator')

    within '.table' do
      expect(page).to have_content user.username
      within 'td:nth-child(4)' do
        expect(page).to have_selector 'a'
      end
    end
  end
end
