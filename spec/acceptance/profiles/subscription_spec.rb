require_relative '../acceptance_helper'

feature 'Subscriptions to pirate diy recipes', %q{
  In order to be able to receive notifications of new pirate diy recipes
  As a user
  I want to be able to subscribe to pirate diy
} do

  given!(:user) { create(:user) }

  scenario 'User tries subscribe to pirate diy', js: true do
    sign_in(user)

    visit settings_path

    within '.form-inline' do
      check 'user_subscribed'
      click_on t('profiles.settings.save_subsribe')
    end
  end
end
