require_relative '../acceptance_helper'

feature 'Search', %q{
  In order to find recipe
  As a any user
  I want to be able to search these
} do

  given!(:public_recipes) { create_list(:public_recipe, 2) }
  given!(:pirate_diy_recipes) { create_list(:pirate_diy_recipe, 2) }
  given!(:private_recipes) { create_list(:recipe, 2) }

  before do
    visit search_path
  end

  scenario 'search in all recipes' do
    find('#query').set(public_recipes[0].name)
    choose 'scope_all'

    click_on t('searches.search_button_text')

    expect(page).to have_link public_recipes[0].name

    find('#query').set(pirate_diy_recipes[0].name)

    click_on t('searches.search_button_text')

    expect(page).to have_link pirate_diy_recipes[0].name
  end

  scenario 'search recipe in public recipes' do
    find('#query').set(public_recipes[0].name)
    choose 'scope_public'

    click_on t('searches.search_button_text')

    expect(page).to have_link public_recipes[0].name
  end

  scenario 'search recipe in pirate diy recipes' do
    find('#query').set(pirate_diy_recipes[0].name)
    choose 'scope_pirate_diy'

    click_on t('searches.search_button_text')

    expect(page).to have_link pirate_diy_recipes[0].name
  end

  scenario 'search private recipe' do
    find('#query').set(private_recipes[0].name)
    choose 'scope_all'

    click_on t('searches.search_button_text')

    expect(page).not_to have_link private_recipes[0].name
  end
end
