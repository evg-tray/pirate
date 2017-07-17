require_relative '../acceptance_helper'

feature 'Remove moderators', %q{
  In order to be able to remove role moderator from user
  As an admin user
  I want to be able to remove moderator
} do

  given!(:user_moderator) { create(:user_moderator) }
  given!(:user_flavor_creator) { create(:user_flavor_creator) }
  given!(:user_pirate_diy_creator) { create(:user_pirate_diy_creator) }
  given!(:user_moderator) { create(:user_moderator) }
  given!(:user_admin) { create(:user_admin) }

  scenario 'User-admin remove role moderator from user', js: true do
    sign_in(user_admin)
    visit admin_path

    within "#user-#{user_moderator.id} td:nth-child(2)" do
      find('a').click
      expect(page).not_to have_selector 'a'
    end
  end

  scenario 'User-admin remove role flavor creator from user', js: true do
    sign_in(user_admin)
    visit admin_path

    within "#user-#{user_flavor_creator.id} td:nth-child(3)" do
      find('a').click
      expect(page).not_to have_selector 'a'
    end
  end

  scenario 'User-admin remove role pirate diy creator from user', js: true do
    sign_in(user_admin)
    visit admin_path

    within "#user-#{user_pirate_diy_creator.id} td:nth-child(4)" do
      find('a').click
      expect(page).not_to have_selector 'a'
    end
  end
end
