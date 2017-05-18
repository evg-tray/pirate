require_relative '../acceptance_helper'

feature 'Create comments', %q{
  In order to be able to comment recipe
  As a user
  I want to be able create comments
} do

  given(:user) { create(:user) }
  given(:recipe) { create(:public_recipe) }
  given(:comment) { create(:comment) }

  scenario 'User creates comment', js: true do
    sign_in(user)

    visit recipe_path(recipe)

    fill_in t('activerecord.attributes.comment.text'), with: comment.text
    click_on t('recipes.comments.create_comment')

    expect(page).to have_content comment.text
    expect(page).not_to have_content t('recipes.comments.no_comments')
  end

  scenario 'Non-authenticated user tries create comment' do
    visit recipe_path(recipe)

    expect(page).not_to have_selector '#comment_text'
  end
end
