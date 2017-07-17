require_relative '../acceptance_helper'

feature 'Delete recipes', %q{
  In order to be able to delete incorrect recipe of liquid
  As a user
  I want to be able delete recipes
} do

  given!(:user) { create(:user) }
  given!(:another_user) { create(:user) }
  given!(:user_admin) { create(:user_admin) }
  given!(:recipe) { create(:public_recipe, author: user) }

  scenario 'author delete recipe', js: true do
    sign_in(user)
    visit recipe_path(recipe)

    click_on t('recipes.manage_buttons.delete_recipe')

    expect(page).not_to have_content recipe.name
    expect(current_path).to eq recipes_path
  end

  scenario 'admin delete recipe', js: true do
    sign_in(user_admin)
    visit recipe_path(recipe)

    click_on t('recipes.manage_buttons.delete_recipe')

    expect(page).not_to have_content recipe.name
    expect(current_path).to eq recipes_path
  end

  scenario 'user tries delete recipe another user', js: true do
    sign_in(another_user)
    visit recipe_path(recipe)

    expect(page).not_to have_link t('recipes.manage_buttons.delete_recipe')
  end
end
