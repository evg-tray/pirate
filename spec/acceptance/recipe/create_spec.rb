require_relative '../acceptance_helper'

feature 'Create recipes', %q{
  In order to be able to save recipe of liquid
  As a user
  I want to be able create recipes
} do

  given(:recipe) { create(:recipe) }
  given(:flavors) { create_list(:flavor, 2) }

  scenario 'Auto fills defaults values' do
    visit new_recipe_path

    expect(find_field('Amount').value).to eq Recipe.load_values[:amount].to_s
    expect(find_field('Pg').value).to eq Recipe.load_values[:pg].to_s
    expect(find_field('Vg').value).to eq Recipe.load_values[:vg].to_s
    expect(find_field('Strength').value).to eq Recipe.load_values[:strength].to_s
    expect(find_field('Nicotine base').value).to eq Recipe.load_values[:nicotine_base].to_s
  end

  scenario 'Any user create recipe' do
    visit new_recipe_path

    fill_in 'Name', with: recipe.name
    click_on 'Создать рецепт'

    visit recipes_path
    expect(page).to have_content recipe.name
  end
end
