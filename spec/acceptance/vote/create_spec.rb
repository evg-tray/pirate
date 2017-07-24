require_relative '../acceptance_helper'

feature 'Create votes', %q{
  In order to be able to vote for recipe
  As a user
  I want to be able vote recipes
} do

  given!(:user) { create(:user) }
  given!(:recipe) { create(:public_recipe) }

  scenario 'User votes for recipe', js: true do
    sign_in(user)

    visit recipe_path(recipe)

    stars = all('.rating .user-rating i')
    stars[4].click
    sleep 1

    visit recipe_path(recipe)
    expect(page).to have_content "4.0/5 1"

    stars = all('.rating .user-rating i')
    stars[0].click
    sleep 1

    visit recipe_path(recipe)
    expect(page).to have_content "0.0/5 0"
  end

  scenario 'Non-authenticated user tries vote for recipe', js: true do
    visit recipe_path(recipe)

    stars = all('.rating .user-rating i')
    stars[4].click
    sleep 1

    visit recipe_path(recipe)
    expect(page).to have_content "0.0/5 0"
  end
end
