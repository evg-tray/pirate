require_relative '../acceptance_helper'

feature 'Search', %q{
  In order to find recipe
  As a any user
  I want to be able to search these
} do

  given!(:public_recipes) { create_list(:recipe, 2, public: true) }
  given!(:pirate_diy_recipes) { create_list(:recipe, 2, pirate_diy: true) }
  given!(:private_recipes) { create_list(:recipe, 2, public: false) }

  before do
    index
    visit search_path
  end

  scenario 'search in all recipes', sphinx: true do
    fill_in 'Query', with: public_recipes[0].name
    choose 'scope_all'
    within '.form-group' do
      click_on 'Search'
    end
    expect(page).to have_link public_recipes[0].name

    fill_in 'Query', with: pirate_diy_recipes[0].name
    within '.form-group' do
      click_on 'Search'
    end
    expect(page).to have_link pirate_diy_recipes[0].name
  end

  scenario 'search recipe in public recipes', sphinx: true do
    fill_in 'Query', with: public_recipes[0].name
    choose 'scope_public'
    within '.form-group' do
      click_on 'Search'
    end
    expect(page).to have_link public_recipes[0].name
  end

  scenario 'search recipe in pirate diy recipes', sphinx: true do
    fill_in 'Query', with: pirate_diy_recipes[0].name
    choose 'scope_pirate_diy'
    within '.form-group' do
      click_on 'Search'
    end
    expect(page).to have_link pirate_diy_recipes[0].name
  end

  scenario 'search private recipe', sphinx: true do
    fill_in 'Query', with: private_recipes[0].name
    choose 'scope_all'
    within '.form-group' do
      click_on 'Search'
    end
    expect(page).not_to have_link private_recipes[0].name
  end
end
