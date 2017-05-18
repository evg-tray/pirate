require_relative '../acceptance_helper'

feature 'View recipes', %q{
  In order to be able to view recipes
  As an any user
  I want to be able view recipes
} do

  given!(:public_recipes) { create_list(:public_recipe, 2) }
  given!(:private_recipes) { create_list(:recipe, 2) }
  given!(:pirate_diy_recipes) { create_list(:pirate_diy_recipe, 2) }

  scenario 'Any user view user`s public recipes' do
    visit recipes_path

    expect(page).to have_content public_recipes[0].name
    expect(page).to have_content public_recipes[1].name

    expect(page).not_to have_content private_recipes[0].name
    expect(page).not_to have_content private_recipes[1].name

    expect(page).not_to have_content pirate_diy_recipes[0].name
    expect(page).not_to have_content pirate_diy_recipes[1].name
  end

  scenario 'Any user view pirate diy recipes' do
    visit root_path

    expect(page).not_to have_content public_recipes[0].name
    expect(page).not_to have_content public_recipes[1].name

    expect(page).not_to have_content private_recipes[0].name
    expect(page).not_to have_content private_recipes[1].name

    expect(page).to have_content pirate_diy_recipes[0].name
    expect(page).to have_content pirate_diy_recipes[1].name
  end
end
