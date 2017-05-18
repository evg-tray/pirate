require_relative '../acceptance_helper'

feature 'User log out', %q{
  In order to end session
  As an user
  I want to be able sign out
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user log out' do
    sign_in(user)

    click_on t('devise.sessions.sign_out')
    expect(page).to have_content t('devise.sessions.signed_out')
  end

end
