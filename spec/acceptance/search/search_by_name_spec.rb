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
    fill_in 'Query', with: public_recipes[0].name
    choose 'scope_all'
    within '.form-group' do
      click_on t('searches.show.search')
    end
    expect(page).to have_link public_recipes[0].name

    fill_in 'Query', with: pirate_diy_recipes[0].name
    within '.form-group' do
      click_on t('searches.show.search')
    end
    expect(page).to have_link pirate_diy_recipes[0].name
  end

  scenario 'search recipe in public recipes' do
    fill_in 'Query', with: public_recipes[0].name
    choose 'scope_public'
    within '.form-group' do
      click_on t('searches.show.search')
    end
    expect(page).to have_link public_recipes[0].name
  end

  scenario 'search recipe in pirate diy recipes' do
    fill_in 'Query', with: pirate_diy_recipes[0].name
    choose 'scope_pirate_diy'
    within '.form-group' do
      click_on t('searches.show.search')
    end
    expect(page).to have_link pirate_diy_recipes[0].name
  end

  scenario 'search private recipe' do
    fill_in 'Query', with: private_recipes[0].name
    choose 'scope_all'
    within '.form-group' do
      click_on t('searches.show.search')
    end
    expect(page).not_to have_link private_recipes[0].name
  end
end
