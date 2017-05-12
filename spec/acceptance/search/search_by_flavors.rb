require_relative '../acceptance_helper'

feature 'Search recipes by flavors', %q{
  In order to find recipes what can i make
  As a any user
  I want to be able to add my flavors in query search
} do

  given!(:recipe1) { create(:recipe, public: true) }
  given!(:recipe2) { create(:recipe, public: true) }
  given!(:recipe3) { create(:recipe, public: true) }
  given!(:recipe_single_flavor) { create(:recipe, public: true) }
  given!(:private_recipe) { create(:recipe) }
  given!(:flavor1) { create(:flavor) }
  given!(:flavor2) { create(:flavor) }
  given!(:flavor3) { create(:flavor) }
  given!(:flavor4) { create(:flavor) }

  before do
    recipe1.flavors << flavor1
    recipe1.flavors << flavor2
    recipe2.flavors << flavor2
    recipe2.flavors << flavor3
    recipe3.flavors << flavor2
    recipe3.flavors << flavor4
    recipe_single_flavor.flavors << flavor4
    private_recipe.flavors << flavor1
    private_recipe.flavors << flavor2
    visit by_flavors_path
  end

  scenario 'search with flavor1 and flavor2', js: true do
    select2(flavor1.name, 'flavor_ids_')
    select2(flavor2.name, 'flavor_ids_')
    click_on 'Search'

    expect(page).to have_content recipe1.name
    expect(page).not_to have_content recipe2.name
    expect(page).not_to have_content recipe3.name
    expect(page).not_to have_content recipe_single_flavor.name
    expect(page).not_to have_content private_recipe.name
  end

  scenario 'search with flavor1 and flavor2 and flavor3', js: true do
    select2(flavor1.name, 'flavor_ids_')
    select2(flavor2.name, 'flavor_ids_')
    select2(flavor3.name, 'flavor_ids_')
    click_on 'Search'

    expect(page).to have_content recipe1.name
    expect(page).to have_content recipe2.name
    expect(page).not_to have_content recipe3.name
    expect(page).not_to have_content recipe_single_flavor.name
    expect(page).not_to have_content private_recipe.name
  end

  scenario 'search with flavor2 and flavor4', js: true do
    select2(flavor2.name, 'flavor_ids_')
    select2(flavor4.name, 'flavor_ids_')
    click_on 'Search'

    expect(page).not_to have_content recipe1.name
    expect(page).not_to have_content recipe2.name
    expect(page).to have_content recipe3.name
    expect(page).to have_content recipe_single_flavor.name
    expect(page).not_to have_content private_recipe.name
  end

  scenario 'search with flavor2 and flavor4 and without single flavor recipes', js: true do
    select2(flavor2.name, 'flavor_ids_')
    select2(flavor4.name, 'flavor_ids_')
    check 'without_single_flavor'
    click_on 'Search'

    expect(page).not_to have_content recipe1.name
    expect(page).not_to have_content recipe2.name
    expect(page).to have_content recipe3.name
    expect(page).not_to have_content recipe_single_flavor.name
    expect(page).not_to have_content private_recipe.name
  end
end
