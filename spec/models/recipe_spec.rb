RSpec.describe Recipe, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(10).is_at_most(200) }
    it_behaves_like 'validable'
  end

  describe 'associations' do
    it { should have_many(:flavors_recipes).inverse_of(:recipe).dependent(:destroy) }
    it { should have_many(:flavors).through(:flavors_recipes) }
    it { should accept_nested_attributes_for(:flavors_recipes).allow_destroy(true) }
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:votes).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:recipe_tastes).dependent(:destroy) }
    it { should have_many(:tastes).through(:recipe_tastes) }
  end

  describe 'indexes' do
    let!(:flavor) { create(:flavor) }
    #let(:recipe) { create(:recipe, flavors: [flavor]) }
    let(:recipe) { create(:recipe) }
    let(:public_recipe) { create(:public_recipe) }
    let(:update_recipe) do
      Proc.new do |rec = recipe|
        rec.update_attributes(name: 'new recipe name')
      end
    end

    it 'update flavors index' do
      expect { update_recipe.call }.to update_index('flavors#flavor').and_reindex(recipe.flavors)
    end

    it 'update recipes index' do
      expect { update_recipe.call }.not_to update_index('recipes#recipe').and_reindex(recipe)
    end

    it 'update recipes index' do
      expect { update_recipe.call(public_recipe) }.to update_index('recipes#recipe').and_reindex(public_recipe)
    end
  end
end
