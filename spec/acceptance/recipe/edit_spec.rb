require_relative '../acceptance_helper'

feature 'Edit recipes', %q{
  In order to be able to correct recipe of liquid
  As a user
  I want to be able edit recipes
} do

  given(:user) { create(:user) }
  given(:recipe) { create(:recipe) }

  scenario 'user edit recipe', js: true do
    sign_in(user)
    visit edit_recipe_path(recipe)

    updated_name = "new recipe name"
    fill_in 'recipe_name', with: updated_name
    click_on 'Сохранить рецепт'

    expect(page).to have_content updated_name
  end
end
