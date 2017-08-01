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
    email = Faker::Internet.unique.email
    find('#user_email').set(email)
    pass = Faker::Internet.password
    find('#user_password').set(pass)
    find('#user_password_confirmation').set(pass)
    click_on t('devise.registrations.new.sign_up')
    open_email(email)
    current_email.click_link t('devise.mailer.confirmation_instructions.action')

    visit new_user_session_path
    find('#user_login').set(email)
    find('#user_password').set(pass)
    within '.actions' do
      click_on t('devise.sessions.new.sign_in')
    end
    expect(page).to have_content t('devise.sessions.signed_in')
  end

end
