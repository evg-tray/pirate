require_relative '../acceptance_helper'

feature 'User log out', %q{
  In order to end session
  As an user
  I want to be able sign out
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user log out' do
    sign_in(user)

    find(".ui.main.menu.computer:not(.placeholder) .dropdown:contains('#{user.username}')").click
    within '.ui.main.menu.computer:not(.placeholder)' do
      click_on t('devise.sessions.sign_out')
    end
    expect(page).to have_content t('devise.sessions.signed_out')
  end

end
