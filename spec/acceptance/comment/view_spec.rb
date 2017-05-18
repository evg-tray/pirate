require_relative '../acceptance_helper'

feature 'View comments', %q{
  In order to be able to view comments to recipe
  As an any user
  I want to be able view comments
} do

  given!(:recipe_without_comments) { create(:public_recipe) }
  given!(:recipe_with_comments) { create(:public_recipe) }
  given!(:comments) { create_list(:comment, 2, recipe: recipe_with_comments) }

  scenario 'Any user view recipe with comments' do
    visit recipe_path(recipe_with_comments)

    expect(page).to have_content comments[0].text
    expect(page).to have_content comments[0].author.username
    expect(page).to have_content comments[1].text
    expect(page).to have_content comments[1].author.username
    expect(page).not_to have_content t('recipes.comments.no_comments')
  end

  scenario 'Any user view recipe with comments' do
    visit recipe_path(recipe_without_comments)

    expect(page).to have_content t('recipes.comments.no_comments')
  end
end
