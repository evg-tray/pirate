require_relative '../acceptance_helper'

feature 'Register user', %q{
  In order to be able to save recipes
  As non-authenticated user
  I want to register new user
} do

  scenario 'Register user' do
    visit new_user_session_path
    click_on t('devise.shared.links.sign_up')
    fill_in t('activerecord.attributes.user.username'), with: Faker::Internet.unique.user_name
    fill_in t('activerecord.attributes.user.email'), with: Faker::Internet.unique.email
    pass = Faker::Internet.password
    fill_in t('activerecord.attributes.user.password'), with: pass
    fill_in t('activerecord.attributes.user.password_confirmation'), with: pass
    click_on t('devise.registrations.new.sign_up')

    expect(page).to have_content t('devise.registrations.signed_up')
  end

end
