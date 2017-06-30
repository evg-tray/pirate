require_relative '../acceptance_helper'

feature 'Edit recipes', %q{
  In order to be able to correct recipe of liquid
  As a user
  I want to be able edit recipes
} do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:user_admin) { create(:user_admin) }
  given(:recipe) { create(:recipe, author: user) }

  scenario 'author edit recipe', js: true do
    sign_in(user)
    visit recipe_path(recipe)

    click_on t('recipes.manage_buttons.edit_recipe')
    updated_name = "new recipe name"
    fill_in 'recipe_name', with: updated_name
    click_on t('recipes.form.save_recipe')

    expect(page).to have_content updated_name
  end

  scenario 'admin edit recipe', js: true do
    sign_in(user_admin)
    visit recipe_path(recipe)

    click_on t('recipes.manage_buttons.edit_recipe')
    updated_name = "new recipe name"
    fill_in 'recipe_name', with: updated_name
    click_on t('recipes.form.save_recipe')

    expect(page).to have_content updated_name
  end

  scenario 'user tries edit recipe another user', js: true do
    sign_in(another_user)
    visit recipe_path(recipe)

    expect(page).not_to have_link t('recipes.manage_buttons.edit_recipe')
  end
end
