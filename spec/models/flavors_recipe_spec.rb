RSpec.describe FlavorsRecipe, type: :model do
  describe 'associations' do
    it { should belong_to(:recipe) }
    it { should belong_to(:flavor) }
  end
end
