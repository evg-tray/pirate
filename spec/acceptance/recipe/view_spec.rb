require_relative '../acceptance_helper'

feature 'View recipes', %q{
  In order to be able to view recipes
  As an any user
  I want to be able view recipes
} do

  scenario 'Any user view flavors' do
    recipes = create_list(:recipe, 2)
    visit recipes_path

    expect(page).to have_content recipes[0].name
    expect(page).to have_content recipes[1].name
  end
end
