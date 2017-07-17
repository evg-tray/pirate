require_relative '../acceptance_helper'

feature 'View my recipes', %q{
  In order to be able to view my recipes
  As user
  I want to be able view my recipes
} do

  given!(:user) { create(:user) }
  given!(:public_recipe) { create(:public_recipe, author: user) }
  given!(:private_recipe) { create(:recipe, author: user) }
  given!(:another_author_public_recipe) { create(:public_recipe) }
  given!(:another_author_private_recipe) { create(:recipe) }
  given!(:pirate_diy_recipe) { create(:pirate_diy_recipe, author: user) }

  scenario 'Non-authenticated user dont see his recipes' do
    visit my_recipes_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'User view his recipes' do
    sign_in(user)
    visit my_recipes_path

    expect(page).to have_content public_recipe.name
    expect(page).to have_content private_recipe.name

    expect(page).not_to have_content another_author_public_recipe.name
    expect(page).not_to have_content another_author_private_recipe.name
  end

  scenario 'User dont see pirate diy recipes in `my recipes` list' do
    sign_in(user)
    visit my_recipes_path

    expect(page).not_to have_content pirate_diy_recipe.name
  end
end
