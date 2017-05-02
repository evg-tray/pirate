require_relative '../acceptance_helper'

feature 'Add recipe to favorites', %q{
  In order to be able to fast find favorite recipe
  As a user
  I want to be able to add recipe in favorites
} do

  given!(:user) { create(:user) }
  given!(:recipe) { create(:public_recipe) }
  given!(:recipe_favorite) { create(:public_recipe) }
  given!(:favorite_recipe) { create(:favorite_recipe, user: user, recipe: recipe_favorite) }

  scenario 'User add recipe to favorites', js: true do
    sign_in(user)

    visit recipe_path(recipe)

    click_on 'Добавить в избранное'

    expect(page).to have_content 'Удалить из избранного'
    visit favorites_path
    expect(page).to have_content recipe.name
  end

  scenario 'Non-authenticated user tries add recipe to favorites' do
    visit recipe_path(recipe)

    expect(page).not_to have_content 'Добавить в избранное'
  end

  scenario 'User delete recipe from favorite', js: true do
    sign_in(user)

    visit recipe_path(recipe_favorite)

    click_on 'Удалить из избранного'
    expect(page).to have_content 'Добавить в избранное'

    visit favorites_path
    expect(page).not_to have_content recipe_favorite.name
  end
end