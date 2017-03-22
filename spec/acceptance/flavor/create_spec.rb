require_relative '../acceptance_helper'

feature 'Create flavors', %q{
  In order to be able to select flavors in recipes
  As a user
  I want to be able create flavors
} do

  given(:flavor) { create(:flavor) }

  scenario 'Any user create flavor' do
    visit new_flavor_path

    fill_in 'Name', with: flavor.name
    click_on 'Создать'

    visit flavors_path
    expect(page).to have_content flavor.name
  end
end
