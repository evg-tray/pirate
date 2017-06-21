require_relative '../acceptance_helper'

feature 'Register user', %q{
  In order to be able to save recipes
  As non-authenticated user
  I want to register new user
} do

  scenario 'Register user' do
    visit new_user_session_path
    click_on t('devise.shared.links.sign_up')
    find('#user_username').set(Faker::Internet.unique.user_name)
    find('#user_email').set(Faker::Internet.unique.email)
    pass = Faker::Internet.password
    find('#user_password').set(pass)
    find('#user_password_confirmation').set(pass)
    click_on t('devise.registrations.new.sign_up')

    expect(page).to have_content t('devise.registrations.signed_up')
  end

end
