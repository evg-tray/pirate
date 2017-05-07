module AcceptanceHelper
  Capybara.server = :puma

  def sign_in(user)
    visit new_user_session_path
    fill_in t('.activerecord.attributes.user.login'), with: user.email
    fill_in t('.activerecord.attributes.user.password'), with: user.password
    within '.actions' do
      click_on t('devise.sessions.new.sign_in')
    end
  end
end
