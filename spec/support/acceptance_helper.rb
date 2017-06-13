module AcceptanceHelper
  Capybara.server = :puma

  def sign_in(user)
    visit new_user_session_path
    find('#user_login').set(user.email)
    find('#user_password').set(user.password)
    within '.actions' do
      click_on t('devise.sessions.new.sign_in')
    end
  end
end
