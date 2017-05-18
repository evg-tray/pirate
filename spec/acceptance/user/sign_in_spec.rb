require_relative '../acceptance_helper'

feature 'User sign in', %q{
  In order to be able to create recipes
  As an user
  I want to be able to sign in
} do

  given(:user) { create(:user) }

  scenario 'Registered user try to sign in' do
    sign_in(user)

    expect(page).to have_content t('.devise.sessions.signed_in')
    expect(current_path).to eq root_path
  end

  scenario 'Registered user try to sign in with username as login' do
    visit new_user_session_path
    fill_in t('.activerecord.attributes.user.login'), with: user.username
    fill_in t('.activerecord.attributes.user.password'), with: user.password
    within '.actions' do
      click_on t('devise.sessions.new.sign_in')
    end

    expect(page).to have_content t('.devise.sessions.signed_in')
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign in' do
    visit new_user_session_path
    fill_in t('.activerecord.attributes.user.login'), with: 'wrong_email@test.com'
    fill_in t('.activerecord.attributes.user.password'), with: '12345678'
    within '.actions' do
      click_on t('devise.sessions.new.sign_in')
    end

    expect(page).to have_content t('devise.failure.not_found_in_database')
    expect(current_path).to eq new_user_session_path
  end
end
