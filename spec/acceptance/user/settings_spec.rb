require_relative '../acceptance_helper'

feature 'Save settings', %q{
  In order to be able to use my favorite values in recipes
  As a user
  I want to be able to edit and save settings
} do

  given(:user) { create(:user) }

  scenario 'User edit his settings' do
    sign_in(user)

    visit settings_path

    find('#user_amount').set(50)
    within '#settings' do
      click_on t('profiles.settings.save')
    end
    visit new_recipe_path
    expect(find_field('recipe_amount').value).to eq '50'
  end

end
