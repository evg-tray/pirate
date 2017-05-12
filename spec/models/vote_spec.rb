RSpec.describe Vote, type: :model do
  describe 'associations' do
    it{ should belong_to(:user) }
    it{ should belong_to(:recipe) }
  end
end
