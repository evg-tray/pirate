require_relative '../acceptance_helper'

feature 'Create recipes', %q{
  In order to be able to save recipe of liquid
  As a user
  I want to be able create recipes
} do

  given!(:user) { create(:user) }
  given!(:recipe) { create(:recipe) }
  given!(:flavors) { create_list(:flavor, 2) }

  scenario 'Auto fills defaults values' do
    sign_in(user)

    visit new_recipe_path

    expect(find_field('recipe_amount').value).to eq Recipe.load_values[:amount].to_s
    expect(find_field('recipe_pg').value).to eq Recipe.load_values[:pg].to_s
    expect(find_field('recipe_vg').value).to eq Recipe.load_values[:vg].to_s
    expect(find_field('recipe_strength').value).to eq Recipe.load_values[:strength].to_s
    expect(find_field('recipe_nicotine_base').value).to eq Recipe.load_values[:nicotine_base].to_s
  end

  scenario 'User create recipe' do
    sign_in(user)

    visit new_recipe_path

    fill_in 'recipe_name', with: recipe.name
    check 'recipe_published'
    click_on 'Сохранить рецепт'

    visit recipes_path
    expect(page).to have_content recipe.name
  end

  scenario 'User create pirate diy recipe' do
    sign_in(user)

    visit new_recipe_path

    fill_in 'recipe_name', with: recipe.name
    check 'recipe_pirate_diy'
    click_on 'Сохранить рецепт'

    visit root_path
    expect(page).to have_content recipe.name
  end

  scenario 'User create recipe with flavors', js: true do
    sign_in(user)

    visit new_recipe_path

    fill_in 'recipe_name', with: recipe.name
    check 'recipe_published'

    click_on 'Добавить ароматизатор'
    click_on 'Добавить ароматизатор'

    selects = all('.flavors-input .select')
    numbers = all('.flavors-input .number')
    selects[0].set(flavors[0].id)
    numbers[0].set(5)
    selects[1].set(flavors[1].id)
    numbers[1].set(2)

    click_on 'Сохранить рецепт'

    expect(page).to have_content recipe.name
    expect(page).to have_content flavors[0].name
    expect(page).to have_content flavors[1].name
  end
end
