RSpec.describe Recipe, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(10).is_at_most(200) }
    it_behaves_like 'validable'
  end

  describe 'associations' do
    it { should have_many(:flavors_recipes).inverse_of(:recipe) }
    it { should have_many(:flavors).through(:flavors_recipes) }
    it { should accept_nested_attributes_for(:flavors_recipes).allow_destroy(true) }
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:votes) }
    it { should have_many(:comments) }
  end

  describe 'indexes' do
    let!(:flavor) { create(:flavor) }
    let(:recipe) { create(:recipe, flavors: [flavor]) }
    let(:update_recipe) { Proc.new { recipe.update_attributes(name: 'new manufacturer name') } }

    it 'update flavors index' do
      expect { update_recipe.call }.to update_index('flavors#flavor').and_reindex(recipe.flavors)
    end
  end
end
