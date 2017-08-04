require_relative '../acceptance_helper'

feature 'View flavors', %q{
  In order to be able to view flavors
  As an any user
  I want to be able view flavors
} do

  given!(:flavors) { create_list(:flavor, 2) }
  given!(:public_recipe) { create(:public_recipe) }
  given!(:pirate_diy_recipe) { create(:pirate_diy_recipe) }
  given!(:private_recipe) { create(:recipe) }

  scenario 'Any user view flavors' do
    visit flavors_path

    expect(page).to have_content flavors[0].name
    expect(page).to have_content flavors[1].name
  end

  before do
    public_recipe.flavors = []
    public_recipe.flavors << flavors[0]
    pirate_diy_recipe.flavors = []
    pirate_diy_recipe.flavors << flavors[0]
    private_recipe.flavors = []
    private_recipe.flavors << flavors[0]
  end

  scenario 'Any user view recipes with flavor' do
    visit flavor_path(flavors[0])

    expect(page).to have_content public_recipe.name
    expect(page).to have_content pirate_diy_recipe.name
    expect(page).not_to have_content private_recipe.name
  end
end
