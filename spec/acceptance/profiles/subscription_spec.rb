require_relative '../acceptance_helper'

feature 'Subscriptions to pirate diy recipes', %q{
  In order to be able to receive notifications of new pirate diy recipes
  As a user
  I want to be able to subscribe to pirate diy
} do

  given!(:user) { create(:user) }
  given!(:user_confirmed) { create(:user_confirmed) }

  scenario 'Non-confirmed user tries subscribe to pirate diy' do
    sign_in(user)

    visit settings_path

    within 'fieldset' do
      expect(page).to have_button('Сохранить', disabled: true)
    end
  end

  scenario 'Сonfirmed user tries subscribe to pirate diy', js: true do
    sign_in(user_confirmed)

    visit settings_path

    within 'fieldset' do
      check 'user_subscribed'
      click_on 'Сохранить'
    end
  end
end
