require_relative '../acceptance_helper'

feature 'Create recipes', %q{
  In order to be able to save recipe of liquid
  As a user
  I want to be able create recipes
} do

  given!(:user) { create(:user) }
  given!(:user_admin) { create(:user_admin) }
  given!(:user_moderator) { create(:user_moderator) }
  given!(:user_pirate_diy_creator) { create(:user_pirate_diy_creator) }
  given!(:recipe) { build(:recipe) }
  given!(:flavors) { create_list(:flavor, 2) }
  given!(:tastes_recipe) { create_list(:taste, 2) }
  given!(:tastes_non_recipe) { create(:taste) }

  scenario 'Auto fills defaults values' do
    sign_in(user)

    visit new_recipe_path

    expect(find_field('recipe_amount').value).to eq Recipe.initial_values(user)[:amount].to_s
    expect(find_field('recipe_pg').value).to eq Recipe.initial_values(user)[:pg].to_s
    expect(find_field('recipe_vg').value).to eq Recipe.initial_values(user)[:vg].to_s
    expect(find_field('recipe_strength').value).to eq Recipe.initial_values(user)[:strength].to_s
    expect(find_field('recipe_nicotine_base').value).to eq Recipe.initial_values(user)[:nicotine_base].to_s
  end

  scenario 'User create private recipe', js: true do
    sign_in(user)

    visit new_recipe_path

    fill_in 'recipe_name', with: recipe.name
    add_flavor

    click_on t('recipes.form.save_recipe')

    visit recipes_path
    expect(page).not_to have_content recipe.name
    visit my_recipes_path
    expect(page).to have_content recipe.name
  end

  scenario 'Confirmed user create public recipe', js: true do
    sign_in(user)

    visit new_recipe_path

    fill_in 'recipe_name', with: recipe.name
    check 'recipe_public'
    add_flavor
    click_on t('recipes.form.save_recipe')

    visit recipes_path
    expect(page).to have_content recipe.name
  end

  scenario 'User does not see pirate diy checkbox' do
    sign_in(user)

    visit new_recipe_path
    expect(page).not_to have_selector('#recipe_pirate_diy')
  end

  scenario 'Admin create pirate diy recipe', js: true do
    sign_in(user_admin)

    visit new_recipe_path
    fill_in 'recipe_name', with: recipe.name
    check 'recipe_pirate_diy'
    add_flavor
    click_on t('recipes.form.save_recipe')

    visit root_path
    expect(page).to have_content recipe.name
  end

  scenario 'Moderator create pirate diy recipe', js: true do
    sign_in(user_moderator)

    visit new_recipe_path

    fill_in 'recipe_name', with: recipe.name
    check 'recipe_pirate_diy'
    add_flavor
    click_on t('recipes.form.save_recipe')

    visit root_path
    expect(page).to have_content recipe.name
  end

  scenario 'Pirate diy creator create pirate diy recipe', js: true do
    sign_in(user_pirate_diy_creator)

    visit new_recipe_path

    fill_in 'recipe_name', with: recipe.name
    check 'recipe_pirate_diy'
    add_flavor
    click_on t('recipes.form.save_recipe')

    visit root_path
    expect(page).to have_content recipe.name
  end

  scenario 'User create recipe with flavors', js: true do
    sign_in(user)

    visit new_recipe_path

    fill_in 'recipe_name', with: recipe.name
    check 'recipe_public'

    click_on t('recipes.form.flavors.add_flavor')
    click_on t('recipes.form.flavors.add_flavor')

    selects = all('.select2-tag')
    amounts = all('.flavor-amount')
    select2(flavors[0].name, selects[0][:id])
    amounts[0].set(5)
    select2(flavors[1].name, selects[1][:id])
    amounts[1].set(2)

    click_on t('recipes.form.save_recipe')

    expect(page).to have_content recipe.name
    expect(page).to have_content flavors[0].name
    expect(page).to have_content flavors[1].name
  end

  scenario 'User create recipe with tastes', js: true do
    sign_in(user)

    visit new_recipe_path

    fill_in 'recipe_name', with: recipe.name
    check 'recipe_public'
    add_flavor

    select2(tastes_recipe[0].name, 'recipe_taste_ids', true)
    select2(tastes_recipe[1].name, 'recipe_taste_ids', true)

    click_on t('recipes.form.save_recipe')

    expect(page).to have_content recipe.name
    expect(page).to have_content tastes_recipe[0].name
    expect(page).to have_content tastes_recipe[1].name
  end

  scenario 'User tries create recipe without flavors', js: true do
    sign_in(user)

    visit new_recipe_path

    fill_in 'recipe_name', with: recipe.name

    click_on t('recipes.form.save_recipe')

    expect(page).to have_content t('activerecord.errors.models.recipe.attributes.base.must_have_flavor')
  end

  def add_flavor
    click_on t('recipes.form.flavors.add_flavor')

    selects = all('.select2-tag')
    amounts = all('.flavor-amount')
    select2(flavors[0].name, selects[0][:id])
    amounts[0].set(5)
  end
end
