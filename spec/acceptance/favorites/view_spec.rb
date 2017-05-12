require_relative '../acceptance_helper'

feature 'View favorites recipes', %q{
  In order to be able to find favorite recipe
  As a user
  I want to be able to view my favorites recipes
} do

  given!(:user) { create(:user) }
  given!(:recipes_favorites) { create_list(:recipe, 2, public: true) }
  given!(:favorite_recipe1) { create(:favorite_recipe, user: user, recipe: recipes_favorites[0]) }
  given!(:favorite_recipe2) { create(:favorite_recipe, user: user, recipe: recipes_favorites[1]) }

  scenario 'User view his favorites recipes and delete one', js: true do
    sign_in(user)

    visit favorites_path

    expect(page).to have_content recipes_favorites[0].name
    expect(page).to have_content recipes_favorites[1].name
    within "#rec-#{recipes_favorites[0].id}" do
      click_on 'Удалить'
    end
    expect(page).not_to have_content recipes_favorites[0].name
  end
end
