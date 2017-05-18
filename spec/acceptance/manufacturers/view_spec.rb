require_relative '../acceptance_helper'

feature 'View manufacturers', %q{
  In order to be able to view manufacturers
  As an any user
  I want to be able view manufacturers
} do

  scenario 'Any user view manufacturers' do
    manufacturers = create_list(:manufacturer, 2)
    visit manufacturers_path

    expect(page).to have_content manufacturers[0].name
    expect(page).to have_content manufacturers[1].name
  end
end
