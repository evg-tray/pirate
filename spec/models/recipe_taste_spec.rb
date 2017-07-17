RSpec.describe RecipeTaste, type: :model do
  describe 'associations' do
    it { should belong_to(:recipe) }
    it { should belong_to(:taste) }
  end
end
