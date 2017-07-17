RSpec.describe Taste, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:recipes).through(:recipe_tastes) }
    it { should have_many(:recipe_tastes) }
  end
end
