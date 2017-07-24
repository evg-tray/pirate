require_relative '../acceptance_helper'

feature 'View ratings', %q{
  In order to be able to choose popular recipe
  As an any user
  I want to be able view rating of recipes
} do

  given!(:public_recipe_with_rating1) { create(:public_recipe, average_rating: 4.2, count_rating: 2) }
  given!(:public_recipe_with_rating2) { create(:public_recipe, average_rating: 3.5, count_rating: 3) }
  given!(:public_recipe_without_rating) { create(:public_recipe, average_rating: 0.0, count_rating: 0) }

  given!(:pirate_diy_recipe_with_rating1) { create(:pirate_diy_recipe, average_rating: 5.0, count_rating: 3) }
  given!(:pirate_diy_recipe_with_rating2) { create(:pirate_diy_recipe, average_rating: 2.3, count_rating: 5) }
  given!(:pirate_diy_recipe_without_rating) { create(:pirate_diy_recipe, average_rating: 0.0, count_rating: 0) }

  scenario 'Any user view ratings in list public recipes', js: true do
    visit recipes_path

    expect(page).to have_content "4.2/5 2"
    expect(page).to have_content "3.5/5 3"
    expect(page).to have_content "0.0/5 0"
  end

  scenario 'Any user view ratings in list pirate diy recipes', js: true do
    visit root_path

    expect(page).to have_content "5.0/5 3"
    expect(page).to have_content "2.3/5 5"
    expect(page).to have_content "0.0/5 0"
  end
end
