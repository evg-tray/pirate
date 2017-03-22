require_relative '../acceptance_helper'

feature 'View flavors', %q{
  In order to be able to view flavors
  As an any user
  I want to be able view flavors
} do

  scenario 'Any user view flavors' do
    flavors = create_list(:flavor, 2)
    visit flavors_path

    expect(page).to have_content flavors[0].name
    expect(page).to have_content flavors[1].name
  end
end
